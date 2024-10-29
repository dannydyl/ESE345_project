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
-- Description : 
--
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_top_level is
	port(
		input_a : in std_logic_vector(127 downto 0);
		input_b : in std_logic_vector(127 downto 0);
		input_c : in std_logic_vector(127 downto 0);
		instr : in std_logic_vector(9 downto 0);
		imme  : in std_logic_vector(15 downto 0);
		output_result : out std_logic_vector(127 downto 0)
	);
end ALU_top_level;

architecture ALU_top_level of ALU_top_level is
	signal instr_type : std_logic_vector(1 downto 0); -- determine the type of instruction Li type, R4 type, R3 type
	signal R3_output_result : std_logic_vector(127 downto 0);	  
	signal Li_output_result : std_logic_vector(127 downto 0);
begin

	-- include the type of instruction

	-- Li type
	li_type : entity work.load_instruction
		port map(
			rs1 => input_a,
			rs2 => input_b,
			rs3 => input_c,
			instruction => instr,
			rd => Li_output_result
		);
	-- R4 type

	-- R3 type
	R3_type : entity work.R3_instruction
		port map(
			a => input_a,
			b => input_b,
			opcode => instr(7 downto 0),
			imme => imme(9 downto 5),
			output_result => R3_output_result
		);


	instr_type <= instr(9 downto 8);
	process(all)
	begin
		if (instr_type(1)) then
			output_result <= Li_output_result;
		else
			if(instr_type = "10") then
				-- R4 type
			elsif(instr_type = "11") then
				output_result <= R3_output_result;
			end if;
		end if;
	end process;

end ALU_top_level;
