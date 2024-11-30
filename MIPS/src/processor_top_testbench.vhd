-------------------------------------------------------------------------------
--
-- Title       : processor_top_testbench
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : //Mac/Home/Documents/SBU_2024_Fall/ESE345/ese345_project/ese345_project/MIPS/src/processor_top_testbench.vhd
-- Generated   : Fri Nov 29 18:10:14 2024
-- From        : Interface description file
-- By          : ItfToHdl ver. 1.0
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;			 
use work.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity processor_top_testbench is
end processor_top_testbench;


architecture processor_top_testbench of processor_top_testbench is
	constant cycle_time : time := 10 ns;

	file instr_file : text;
	file output_file : text;

	signal clk : std_logic;
	signal rst : std_logic;
	signal load_en : std_logic;
	signal instruction : std_logic_vector(24 downto 0);
begin

	processor_inst : entity work.Processor_top_level
		port map(
			clk => clk,
			rst => rst,
			load_en => load_en,
			instruction => instruction
		);

	clock: process
	begin
		for i in 0 to 2000 loop
			clk <= '0';
			wait for cycle_time/2;
			clk <= '1';
			wait for cycle_time/2;
		end loop;
	end process clock;

	feeding_instructions: process
	variable instr_line : line;
	variable instr_temp : std_logic_vector(24 downto 0);
	begin
		file_open(instr_file, "instructions.txt", read_mode);
		
		rst <= '1';
		wait for 2*cycle_time;

		load_en <= '1';
		rst <= '0';

		while not endfile(instr_file) loop
			readline(instr_file, instr_line);
			read(instr_line, instr_temp);
			
			instruction <= instr_temp;
			
			wait until rising_edge(clk);
		end loop;

		report "Done loading instructions into instr_buffer";
		wait;
		std.env.stop;
	end process feeding_instructions;
	

end processor_top_testbench;
