-------------------------------------------------------------------------------
--
-- Title       : CLZ
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : //Mac/Home/Documents/SBU_2024_Fall/ESE345/ese345_project/ese345_project/MIPS/src/CLZ.vhd
-- Generated   : Tue Oct 22 23:09:00 2024
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

entity CLZ is		 
	port(
	input_hw : in std_logic_vector(15 downto 0);	 -- input should be 8 and output also should be 8
	count		 : out std_logic_vector(15 downto 0)
	);
end CLZ;


architecture CLZ of CLZ is 

begin
	process(input_hw)
	variable count_zeros : integer := 0;
	begin
		for i in 15 downto 0 loop
			if input_hw(i) = '0' then
				count_zeros := count_zeros + 1;
			else
				exit;
			end if;
		end loop;
		
		count <= std_logic_vector(to_unsigned(count_zeros, 16));
	end process;
end CLZ;
