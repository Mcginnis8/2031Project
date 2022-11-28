-- Simple DDS tone generator.
-- 5-bit tuning word
-- 9-bit phase register
-- 256 x 8-bit ROM.

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

LIBRARY ALTERA_MF;
USE ALTERA_MF.ALTERA_MF_COMPONENTS.ALL;


ENTITY TONE_GEN IS 
	PORT
	(
		CMD        	: INOUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		CS         	: IN  STD_LOGIC;
		CHAN_SEL		: IN  STD_LOGIC; -- IO address selection to toggle left and right channels
		SAMPLE_CLK 	: IN  STD_LOGIC; 
		RESETN     	: IN  STD_LOGIC;
		CLK_100HZ	: IN  STD_LOGIC; -- clock for duration control allows for duration of 10 milliseconds
		DUR_SEL		: IN  STD_LOGIC; -- IO address selection to enable note duration control
		IO_WRITE		: IN  STD_LOGIC; -- signal from SCOMP to interact with added functionality addresses
		
		L_DATA     	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		R_DATA     	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END TONE_GEN;

ARCHITECTURE gen OF TONE_GEN IS 
	TYPE channel_state IS (both, left_s, right_s, none);
	SIGNAL channel_output	: channel_state;

	SIGNAL phase_register 	: STD_LOGIC_VECTOR(14 DOWNTO 0);
	SIGNAL tuning_word    	: STD_LOGIC_VECTOR(14 DOWNTO 0);
	SIGNAL sounddata      	: STD_LOGIC_VECTOR(8 DOWNTO 0);
	SIGNAL time_passed		: STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000"; -- data 
	SIGNAL time_to_stop	   : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL timer_en			: STD_LOGIC := '0';
	SIGNAL equal				: STD_LOGIC := '0';
	SIGNAL status				: STD_LOGIC_VECTOR(2 DOWNTO 0);
	
BEGIN

	-- ROM to hold the waveform
	SOUND_LUT : altsyncram
	GENERIC MAP (
		lpm_type => "altsyncram",
		width_a => 9,
		widthad_a => 10,
		numwords_a => 1024,
		init_file => "SOUND_SINE.mif",
		intended_device_family => "Cyclone II",
		lpm_hint => "ENABLE_RUNTIME_MOD=NO",
		operation_mode => "ROM",
		outdata_aclr_a => "NONE",
		outdata_reg_a => "UNREGISTERED",
		power_up_uninitialized => "FALSE"
	)
	PORT MAP (
		clock0 => NOT(SAMPLE_CLK),
		-- In this design, one bit of the phase register is a fractional bit
		address_a => phase_register(14 downto 5),
		q_a => sounddata -- output is amplitude
	);
	
	CMD <= "000000000000000" & equal WHEN ((DUR_SEL='1') AND (IO_WRITE='0')) ELSE "ZZZZZZZZZZZZZZZZ";
	
	-- process to perform DDS
	PROCESS(RESETN, SAMPLE_CLK) BEGIN
		IF RESETN = '0' THEN
			phase_register <= "000000000000000";
		ELSIF RISING_EDGE(SAMPLE_CLK) THEN
			IF tuning_word = "000000000000000" THEN  -- if command is 0, return to 0 output.
				phase_register <= "000000000000000";
			ELSE
				-- Increment the phase register by the tuning word.
				phase_register <= phase_register + (tuning_word);
			END IF;
		END IF;
	END PROCESS;
	

	-- process to latch command data from SCOMP
	PROCESS(RESETN, CS, CHAN_SEL) BEGIN
		IF RESETN = '0' THEN
			tuning_word <= "000000000000000";
		ELSIF RISING_EDGE(CS) THEN
			tuning_word <= CMD(14 DOWNTO 0);
		END IF;
		
	END PROCESS;
	
	PROCESS(RESETN, DUR_SEL, CLK_100HZ, CS) BEGIN
	
		IF RISING_EDGE(DUR_SEL) and IO_WRITE='1' THEN
			timer_en <= '1';
			time_to_stop <= CMD;
		END IF;
		
		IF DUR_SEL = '1' and IO_WRITE='1' THEN
			time_passed <= "0000000000000000";
			equal <= '0';
		ELSIF RISING_EDGE(CLK_100HZ) THEN
			if (cs /= '1') THEN
				time_passed <= time_passed + "0000000000000001";
			ELSE
				equal <= '0';
				time_passed <= "0000000000000000";
			END IF;
			
			IF time_passed >= time_to_stop AND timer_en = '1' THEN
				equal <= '1';
			ELSE
				equal <= '0';
			END IF;
		END IF;
	
	END PROCESS;
	
	
	PROCESS(CHAN_SEL) BEGIN
		IF RISING_EDGE(CHAN_SEL) THEN
			CASE CMD(1 DOWNTO 0) IS
				WHEN "00" =>
					channel_output <= none;
				WHEN "01" =>
					channel_output <= right_s;
				WHEN "10" =>
					channel_output <= left_s;
				WHEN "11" =>
					channel_output <= both;
			END CASE;
		END IF;
	END PROCESS;
	
	L_DATA <= sounddata(8)&sounddata(8)&sounddata(8)&sounddata&"0000" WHEN (channel_output = left_s AND equal /= '1') or (channel_output = both AND equal /= '1') else "0000000000000000";
	R_DATA <= sounddata(8)&sounddata(8)&sounddata(8)&sounddata&"0000" WHEN (channel_output = right_s AND equal /= '1') or (channel_output = both AND equal /= '1') else "0000000000000000";
	
END gen;