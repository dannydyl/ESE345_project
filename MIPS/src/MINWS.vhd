-------------------------------------------------------------------------------
--
-- Title       : MINWS
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : //Mac/Home/Documents/SBU_2024_Fall/ESE345/ese345_project/ese345_project/MIPS/src/MINWS.vhd
-- Generated   : Wed Oct 23 15:50:22 2024
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

entity MINWS is
	port(
		input_a : in std_logic_vector(127 downto 0);
		input_b : in std_logic_vector(127 downto 0);
		output_result : out std_logic_vector(127 downto 0)
	);
end MINWS;

architecture MINWS of MINWS is
	signal a_w_index3 : std_logic_vector(31 downto 0);
	signal a_w_index2 : std_logic_vector(31 downto 0);
	signal a_w_index1 : std_logic_vector(31 downto 0);
	signal a_w_index0 : std_logic_vector(31 downto 0);

	signal b_w_index3 : std_logic_vector(31 downto 0);
	signal b_w_index2 : std_logic_vector(31 downto 0);
	signal b_w_index1 : std_logic_vector(31 downto 0);
	signal b_w_index0 : std_logic_vector(31 downto 0);

	signal result_w_index3 : std_logic_vector(31 downto 0);
	signal result_w_index2 : std_logic_vector(31 downto 0);
	signal result_w_index1 : std_logic_vector(31 downto 0);
	signal result_w_index0 : std_logic_vector(31 downto 0);
begin
	a_w_index3 <= input_a(127 downto 96);
	a_w_index2 <= input_a(95 downto 64);
	a_w_index1 <= input_a(63 downto 32);
	a_w_index0 <= input_a(31 downto 0);

	b_w_index3 <= input_b(127 downto 96);
	b_w_index2 <= input_b(95 downto 64);
	b_w_index1 <= input_b(63 downto 32);
	b_w_index0 <= input_b(31 downto 0);

	output_result <= result_w_index3 & result_w_index2 & result_w_index1 & result_w_index0;

	process(a_w_index3, b_w_index3)
  begin
		if (signed(a_w_index3) < signed(b_w_index3)) then
			result_w_index3 <= a_w_index3;
		else
			result_w_index3 <= b_w_index3;
		end if;
	end process;

	process(a_w_index2, b_w_index2)
	begin
		if (signed(a_w_index2) < signed(b_w_index2)) then
			result_w_index2 <= a_w_index2;
		else
			result_w_index2 <= b_w_index2;
		end if;
	end process;

	process(a_w_index1, b_w_index1)
	begin
		if (signed(a_w_index1) < signed(b_w_index1)) then
			result_w_index1 <= a_w_index1;
		else
			result_w_index1 <= b_w_index1;
		end if;
	end process;

	process(a_w_index0, b_w_index0)
	begin
		if (signed(a_w_index0) < signed(b_w_index0)) then
			result_w_index0 <= a_w_index0;
		else
			result_w_index0 <= b_w_index0;
		end if;
	end process;
end MINWS;
