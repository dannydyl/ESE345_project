-------------------------------------------------------------------------------
--
-- Title       : IF_ID_Reg
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : //Mac/Home/Documents/SBU_2024_Fall/ESE345/ese345_project/ese345_project/MIPS/src/IF_ID_Reg.vhd
-- Generated   : Tue Nov 26 22:03:32 2024
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

entity IF_ID_Reg is
	port(
		clk : in std_logic;
		rst : in std_logic;
		instruction_in : in std_logic_vector(24 downto 0);
		instruction_out : out std_logic_vector(24 downto 0)
	);
end IF_ID_Reg;

architecture behavioral of IF_ID_Reg is
begin
	process(clk, rst)
	begin
		if rst = '1' then
			instruction_out <= (others => '0');
		elsif rising_edge(clk) then
			instruction_out <= instruction_in;
		end if;
	end process;
end IF_ID_Reg;
