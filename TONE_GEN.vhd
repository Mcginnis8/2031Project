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
		CMD        : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		CS         : IN  STD_LOGIC;
		SAMPLE_CLK : IN  STD_LOGIC;
		RESETN     : IN  STD_LOGIC;
		L_DATA     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		R_DATA     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END TONE_GEN;

ARCHITECTURE gen OF TONE_GEN IS 

	SIGNAL phase_register     : STD_LOGIC_VECTOR(8 DOWNTO 0);
	SIGNAL phase_register_fix : STD_LOGIC_VECTOR(6 DOWNTO 1);
	SIGNAL tuning_word        : STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL sounddata          : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL sounddata_fix      : STD_LOGIC_VECTOR(7 DOWNTO 0);
	
BEGIN

	-- ROM to hold the waveform
	--  SOUND_LUT : altsyncram
	--  GENERIC MAP (
	--  	lpm_type => "altsyncram",
	--  	width_a => 8,
	--  	widthad_a => 8,
	--  	numwords_a => 256,
	--  	init_file => "SOUND_SINE.mif",
	--  	intended_device_family => "Cyclone II",
	--  	lpm_hint => "ENABLE_RUNTIME_MOD=NO",
	--  	operation_mode => "ROM",
	--  	outdata_aclr_a => "NONE",
	--  	outdata_reg_a => "UNREGISTERED",
	--  	power_up_uninitialized => "FALSE"
	--  )
	--  PORT MAP (
	--  	clock0 => NOT(SAMPLE_CLK),
	--  	-- In this design, one bit of the phase register is a fractional bit
	--  	address_a => phase_register(8 downto 1),
	--  	q_a => sounddata -- output is amplitude
	--  );

	--  SOUND_LUT_HALF : altsyncram
	--  GENERIC MAP (
	--  	lpm_type => "altsyncram",
	--  	width_a => 8,
	--  	widthad_a => 7,
	--  	numwords_a => 128,
	--  	init_file => "SOUND_SINE_HALF.mif",
	--  	intended_device_family => "Cyclone II",
	--  	lpm_hint => "ENABLE_RUNTIME_MOD=NO",
	--  	operation_mode => "ROM",
	--  	outdata_aclr_a => "NONE",
	--  	outdata_reg_a => "UNREGISTERED",
	--  	power_up_uninitialized => "FALSE"
	--  )
	--  PORT MAP (
	--  	clock0 => NOT(SAMPLE_CLK),
	--  	-- In this design, one bit of the phase register is a fractional bit
	--  	address_a => phase_register(7 downto 1),
	--  	q_a => sounddata -- output is amplitude
	--  );

	SOUND_LUT_QUAD : altsyncram
	GENERIC MAP (
		lpm_type => "altsyncram",
		width_a => 8,
		widthad_a => 6,
		numwords_a => 64,
		init_file => "SOUND_SINE_QUAD.mif",
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
		address_a => phase_register_fix(6 downto 1),
		q_a => sounddata -- output is amplitude
	);
	
	PROCESS(phase_register(7 downto 1)) BEGIN
		IF phase_register(6 downto 1) = "000000" THEN
			phase_register_fix(6 downto 1) <= (others => phase_register(7));
		ELSIF phase_register(7) = '0' THEN
			phase_register_fix(6 downto 1) <= phase_register(6 downto 1);
		ELSE
			phase_register_fix(6 downto 1) <= NOT(phase_register(6 downto 1));
		END IF;
	END PROCESS;

	PROCESS(phase_register(8), sounddata) BEGIN
		IF phase_register(8) = '0' THEN
			-- Copy the read out sound data and directly use for data output
			sounddata_fix <= sounddata;
		ELSE
			-- Negate the read out sound data with 2's complement
			sounddata_fix <= NOT(sounddata) + "00000001";
		END IF;
	END PROCESS;

	-- 8-bit sound data is used as bits 12-5 of the 16-bit output.
	-- This is to prevent the output from being too loud.
	L_DATA(15 DOWNTO 13) <= sounddata_fix(7)&sounddata_fix(7)&sounddata_fix(7); -- sign extend
	L_DATA(12 DOWNTO 5) <= sounddata_fix;
	L_DATA(4 DOWNTO 0) <= "00000"; -- pad right side with 0s
	
	-- Right channel is the same.
	R_DATA(15 DOWNTO 13) <= sounddata_fix(7)&sounddata_fix(7)&sounddata_fix(7); -- sign extend
	R_DATA(12 DOWNTO 5) <= sounddata_fix;
	R_DATA(4 DOWNTO 0) <= "00000"; -- pad right side with 0s
	
	-- process to perform DDS
	PROCESS(RESETN, SAMPLE_CLK) BEGIN
		IF RESETN = '0' THEN
			phase_register <= "000000000";
		ELSIF RISING_EDGE(SAMPLE_CLK) THEN
			IF tuning_word = "00000" THEN  -- if command is 0, return to 0 output.
				phase_register <= "000000000";
			ELSE
				-- Increment the phase register by the tuning word.
				phase_register <= phase_register + ("0000" & tuning_word);
			END IF;
		END IF;
	END PROCESS;

	-- process to latch command data from SCOMP
	PROCESS(RESETN, CS) BEGIN
		IF RESETN = '0' THEN
			tuning_word <= "00000";
		ELSIF RISING_EDGE(CS) THEN
			tuning_word <= CMD(4 DOWNTO 0);
		END IF;
	END PROCESS;
END gen;
