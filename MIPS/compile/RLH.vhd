-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\compile\RLH.vhd
-- Generated   : Sat Nov 30 22:50:45 2024
-- From        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\..\RLH.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity RLH is
  port(
       input_a : in STD_LOGIC_VECTOR(127 downto 0);
       input_b : in STD_LOGIC_VECTOR(127 downto 0);
       output_result : out STD_LOGIC_VECTOR(127 downto 0)
  );
end RLH;

architecture RLH of RLH is

---- Signal declarations used on the diagram ----

signal a_shamt_index0 : STD_LOGIC_VECTOR(3 downto 0);
signal a_shamt_index1 : STD_LOGIC_VECTOR(3 downto 0);
signal a_shamt_index2 : STD_LOGIC_VECTOR(3 downto 0);
signal a_shamt_index3 : STD_LOGIC_VECTOR(3 downto 0);
signal a_shamt_index4 : STD_LOGIC_VECTOR(3 downto 0);
signal a_shamt_index5 : STD_LOGIC_VECTOR(3 downto 0);
signal a_shamt_index6 : STD_LOGIC_VECTOR(3 downto 0);
signal a_shamt_index7 : STD_LOGIC_VECTOR(3 downto 0);
signal b_hw_index0 : STD_LOGIC_VECTOR(15 downto 0);
signal b_hw_index1 : STD_LOGIC_VECTOR(15 downto 0);
signal b_hw_index2 : STD_LOGIC_VECTOR(15 downto 0);
signal b_hw_index3 : STD_LOGIC_VECTOR(15 downto 0);
signal b_hw_index4 : STD_LOGIC_VECTOR(15 downto 0);
signal b_hw_index5 : STD_LOGIC_VECTOR(15 downto 0);
signal b_hw_index6 : STD_LOGIC_VECTOR(15 downto 0);
signal b_hw_index7 : STD_LOGIC_VECTOR(15 downto 0);
signal result_hw_index0 : STD_LOGIC_VECTOR(15 downto 0);
signal result_hw_index1 : STD_LOGIC_VECTOR(15 downto 0);
signal result_hw_index2 : STD_LOGIC_VECTOR(15 downto 0);
signal result_hw_index3 : STD_LOGIC_VECTOR(15 downto 0);
signal result_hw_index4 : STD_LOGIC_VECTOR(15 downto 0);
signal result_hw_index5 : STD_LOGIC_VECTOR(15 downto 0);
signal result_hw_index6 : STD_LOGIC_VECTOR(15 downto 0);
signal result_hw_index7 : STD_LOGIC_VECTOR(15 downto 0);

begin

---- User Signal Assignments ----
b_hw_index7 <= input_b(127 downto 112);
b_hw_index6 <= input_b(111 downto 96);
b_hw_index5 <= input_b(95 downto 80);
b_hw_index4 <= input_b(79 downto 64);
b_hw_index3 <= input_b(63 downto 48);
b_hw_index2 <= input_b(47 downto 32);
b_hw_index1 <= input_b(31 downto 16);
b_hw_index0 <= input_b(15 downto 0);
a_shamt_index7 <= input_a(115 downto 112);
a_shamt_index6 <= input_a(99 downto 96);
a_shamt_index5 <= input_a(83 downto 80);
a_shamt_index4 <= input_a(67 downto 64);
a_shamt_index3 <= input_a(51 downto 48);
a_shamt_index2 <= input_a(35 downto 32);
a_shamt_index1 <= input_a(19 downto 16);
a_shamt_index0 <= input_a(3 downto 0);
result_hw_index7 <= std_logic_vector(rotate_left(unsigned(b_hw_index7),to_integer(unsigned(a_shamt_index7))));
result_hw_index6 <= std_logic_vector(rotate_left(unsigned(b_hw_index6),to_integer(unsigned(a_shamt_index6))));
result_hw_index5 <= std_logic_vector(rotate_left(unsigned(b_hw_index5),to_integer(unsigned(a_shamt_index5))));
result_hw_index4 <= std_logic_vector(rotate_left(unsigned(b_hw_index4),to_integer(unsigned(a_shamt_index4))));
result_hw_index3 <= std_logic_vector(rotate_left(unsigned(b_hw_index3),to_integer(unsigned(a_shamt_index3))));
result_hw_index2 <= std_logic_vector(rotate_left(unsigned(b_hw_index2),to_integer(unsigned(a_shamt_index2))));
result_hw_index1 <= std_logic_vector(rotate_left(unsigned(b_hw_index1),to_integer(unsigned(a_shamt_index1))));
result_hw_index0 <= std_logic_vector(rotate_left(unsigned(b_hw_index0),to_integer(unsigned(a_shamt_index0))));
output_result <= result_hw_index7 & result_hw_index6 & result_hw_index5 & result_hw_index4 & result_hw_index3 & result_hw_index2 & result_hw_index1 & result_hw_index0;

end RLH;
