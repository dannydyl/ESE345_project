-------------------------------------------------------------------------------
--
-- Title       : ALU_top_level
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : //Mac/Home/Documents/SBU_2024_Fall/ESE345/ese345_project/ese345_project/MIPS/src/ALU_top_level.vhd
-- Generated   : Mon Oct 28 00:05:23 2024
-- From        : Interface description file
-- By          : ItfToHdl ver. 1.0
--
-------------------------------------------------------------------------------
--
-- Description : Compiled with VHDL2009 
--
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_top_level is
	port(
		input_rs3 : in std_logic_vector(127 downto 0); -- from rs3
		input_rs2 : in std_logic_vector(127 downto 0); -- from rs2 
		input_rs1 : in std_logic_vector(127 downto 0); -- from rs1
		input_rd : in std_logic_vector(127 downto 0); -- from rd
		instr : in std_logic_vector(9 downto 0);
		imme  : in std_logic_vector(15 downto 0);
		output_result : out std_logic_vector(127 downto 0)
	);
end ALU_top_level;

architecture ALU_top_level of ALU_top_level is
	signal instr_type : std_logic_vector(1 downto 0); -- determine the type of instruction Li type, R4 type, R3 type
	signal R3_output_result : std_logic_vector(127 downto 0);	  
	signal Li_output_result : std_logic_vector(127 downto 0);						
	signal R4_output_result : std_logic_vector(127 downto 0);
begin

	-- Li type
	li_type : entity work.load_instruction
		port map(
			old_rd => input_rd, -- take R[rd] from rs1 port
			load_index => instr(8 downto 6),
			immediate => imme,
			new_rd => Li_output_result
		);

	-- R4 type
	R4_type : entity work.R4_instruction
		port map(
			rs1 => input_rs1,
			rs2 => input_rs2,
			rs3 => input_rs3,
			opcode => instr(7 downto 5), -- [22:20] from the full instruction
			rd_out => R4_output_result
		);

	-- R3 type
	R3_type : entity work.R3_instruction
		port map(
			a => input_rs2,
			b => input_rs1,
			opcode => instr(7 downto 0),
			imme => imme(9 downto 5), -- for rs2 bit field immediate value
			result => R3_output_result
		);


	instr_type <= instr(9 downto 8);	
	
	with instr_type select
	output_result <= R4_output_result when "10",
					 R3_output_result when "11",
					 Li_output_result when others;

end ALU_top_level;
