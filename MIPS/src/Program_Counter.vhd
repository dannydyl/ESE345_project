-------------------------------------------------------------------------------
--
-- Title       : Program_Counter
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : //Mac/Home/Documents/SBU_2024_Fall/ESE345/ese345_project/ese345_project/MIPS/src/Program_Counter.vhd
-- Generated   : Tue Nov 26 22:35:55 2024
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

entity Program_Counter is
	port(
		clk : in std_logic;
		rst : in std_logic;
		PC_out : out std_logic_vector(5 downto 0);
		PC_out_2 : out std_logic_vector(5 downto 0)
	);
end Program_Counter;

architecture Program_Counter of Program_Counter is
signal counter : unsigned(5 downto 0);
begin
	process(clk, rst)
	begin
		if rst = '1' then
			counter <= (others => '0');
		elsif rising_edge(clk) then
			counter <= counter + 1;
		end if;
	end process;

	PC_out <= std_logic_vector(counter);
	PC_out_2 <= std_logic_vector(counter);

end Program_Counter;
