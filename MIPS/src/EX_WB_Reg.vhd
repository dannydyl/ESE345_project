-------------------------------------------------------------------------------
--
-- Title       : EX_WB
-- Design      : EX_WB
-- Author      : Aritro
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:/My_Designs/345_Part2/EX_WB/src/EX_WB.vhd
-- Generated   : Thu Nov 28 13:17:17 2024
-- From        : Interface description file
-- By          : ItfToHdl ver. 1.0
--
-------------------------------------------------------------------------------
--
-- Description : EX/WB Pipeline Register that forwards instruction and associated data
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.NUMERIC_STD.ALL;

entity EX_WB_Reg is
	port(
		clk : in std_logic;
		rst : in std_logic;
		rd_address_in : in std_logic_vector(4 downto 0);
		rd_in : in STD_LOGIC_VECTOR(127 downto 0);
		write_en_in : in std_logic;
		
		rd_address_out : out std_logic_vector(4 downto 0);
		rd_out : out STD_LOGIC_VECTOR(127 downto 0);
		write_en_out : out std_logic
	);
end EX_WB_Reg;

architecture behavior of EX_WB_Reg is
begin
	process(clk, rst)
	begin
		if rst = '1' then 
			rd_address_out <= (others => '0');
			rd_out <= std_logic_vector(to_unsigned(0, 128));
			write_en_out <= '0';
		elsif rising_edge(clk) then
			rd_address_out <= rd_address_in;
			rd_out <= rd_in;
			write_en_out <= write_en_in;
		end if;
   end process;
end behavior;
