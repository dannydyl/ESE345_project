-------------------------------------------------------------------------------
--
-- Title       : RLH
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : //Mac/Home/Documents/SBU_2024_Fall/ESE345/ese345_project/ese345_project/MIPS/src/RLH.vhd
-- Generated   : Wed Oct 23 23:49:26 2024
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

entity RLH is
	port(
		input_a : in std_logic_vector(127 downto 0);
		input_b : in std_logic_vector(127 downto 0);
		output_result : out std_logic_vector(127 downto 0)
	);
end RLH;

architecture RLH of RLH is
	signal a_hw_index7 : std_logic_vector(15 downto 0);
	signal a_hw_index6 : std_logic_vector(15 downto 0);
	signal a_hw_index5 : std_logic_vector(15 downto 0);
	signal a_hw_index4 : std_logic_vector(15 downto 0);
	signal a_hw_index3 : std_logic_vector(15 downto 0);
	signal a_hw_index2 : std_logic_vector(15 downto 0);
	signal a_hw_index1 : std_logic_vector(15 downto 0);
	signal a_hw_index0 : std_logic_vector(15 downto 0);

	signal b_shamt_index7 : std_logic_vector(3 downto 0);
	signal b_shamt_index6 : std_logic_vector(3 downto 0);
	signal b_shamt_index5 : std_logic_vector(3 downto 0);
	signal b_shamt_index4 : std_logic_vector(3 downto 0);
	signal b_shamt_index3 : std_logic_vector(3 downto 0);
	signal b_shamt_index2 : std_logic_vector(3 downto 0);
	signal b_shamt_index1 : std_logic_vector(3 downto 0);
	signal b_shamt_index0 : std_logic_vector(3 downto 0);

	signal result_hw_index7 : std_logic_vector(15 downto 0);
	signal result_hw_index6 : std_logic_vector(15 downto 0);
	signal result_hw_index5 : std_logic_vector(15 downto 0);
	signal result_hw_index4 : std_logic_vector(15 downto 0);
	signal result_hw_index3 : std_logic_vector(15 downto 0);
	signal result_hw_index2 : std_logic_vector(15 downto 0);
	signal result_hw_index1 : std_logic_vector(15 downto 0);
	signal result_hw_index0 : std_logic_vector(15 downto 0);
begin
	a_hw_index7 <= input_a(127 downto 112);
	a_hw_index6 <= input_a(111 downto 96);
	a_hw_index5 <= input_a(95 downto 80);
	a_hw_index4 <= input_a(79 downto 64);
	a_hw_index3 <= input_a(63 downto 48);
	a_hw_index2 <= input_a(47 downto 32);
	a_hw_index1 <= input_a(31 downto 16);
	a_hw_index0 <= input_a(15 downto 0);

	b_shamt_index7 <= input_b(115 downto 112);
	b_shamt_index6 <= input_b(99 downto 96);
	b_shamt_index5 <= input_b(83 downto 80);
	b_shamt_index4 <= input_b(67 downto 64);
	b_shamt_index3 <= input_b(51 downto 48);
	b_shamt_index2 <= input_b(35 downto 32);
	b_shamt_index1 <= input_b(19 downto 16);
	b_shamt_index0 <= input_b(3 downto 0);

	result_hw_index7 <= rotate_left(a_hw_index7, to_integer(unsigned(b_shamt_index7), 4));
	result_hw_index6 <= rotate_left(a_hw_index6, to_integer(unsigned(b_shamt_index6), 4));
	result_hw_index5 <= rotate_left(a_hw_index5, to_integer(unsigned(b_shamt_index5), 4));
	result_hw_index4 <= rotate_left(a_hw_index4, to_integer(unsigned(b_shamt_index4), 4));
	result_hw_index3 <= rotate_left(a_hw_index3, to_integer(unsigned(b_shamt_index3), 4));
	result_hw_index2 <= rotate_left(a_hw_index2, to_integer(unsigned(b_shamt_index2), 4));
	result_hw_index1 <= rotate_left(a_hw_index1, to_integer(unsigned(b_shamt_index1), 4));
	result_hw_index0 <= rotate_left(a_hw_index0, to_integer(unsigned(b_shamt_index0), 4));

	output_result <= result_hw_index7 & result_hw_index6 & result_hw_index5 & result_hw_index4 & result_hw_index3 & result_hw_index2 & result_hw_index1 & result_hw_index0;

end RLH;
