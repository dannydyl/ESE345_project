-------------------------------------------------------------------------------
--
-- Title       : ID_EX_Reg
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : //Mac/Home/Documents/SBU_2024_Fall/ESE345/ese345_project/ese345_project/MIPS/src/ID_EX_Reg.vhd
-- Generated   : Tue Nov 26 22:03:52 2024
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

entity ID_EX_Reg is
	port(
		clk : in std_logic;
		rst : in std_logic;
		instr_opcode_in : in std_logic_vector(9 downto 0);
		instr_imme_in : in std_logic_vector(15 downto 0);
		instr_rd_in : in std_logic_vector(4 downto 0);
		rs1_data_in : in std_logic_vector(127 downto 0);
		rs2_data_in : in std_logic_vector(127 downto 0);
		rs3_data_in : in std_logic_vector(127 downto 0);
		
		instr_opcode_out : out std_logic_vector(9 downto 0);
		instr_imme_out : out std_logic_vector(15 downto 0);
		instr_rd_out : out std_logic_vector(4 downto 0);
		rs1_data_out : out std_logic_vector(127 downto 0);
		rs2_data_out : out std_logic_vector(127 downto 0);
		rs3_data_out : out std_logic_vector(127 downto 0)
	);
end ID_EX_Reg;

architecture behavioral of ID_EX_Reg is
begin
	process(clk, rst)
	begin
		if rst = '1' then
			instruction_out <= (others => '0');
		elsif rising_edge(clk) then
			instruction_out <= instruction_in;
		end if;
	end process;
end ID_EX_Reg;
