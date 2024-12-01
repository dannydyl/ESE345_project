-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\compile\MLHCU.vhd
-- Generated   : Sat Nov 30 22:50:36 2024
-- From        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\..\MLHCU.bde
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

entity MLHCU is
  port(
       input_a : in STD_LOGIC_VECTOR(127 downto 0);
       input_const : in STD_LOGIC_VECTOR(4 downto 0);
       output_result : out STD_LOGIC_VECTOR(127 downto 0)
  );
end MLHCU;

architecture MLHCU of MLHCU is

---- Signal declarations used on the diagram ----

signal a_w_low_index0 : STD_LOGIC_VECTOR(15 downto 0);
signal a_w_low_index1 : STD_LOGIC_VECTOR(15 downto 0);
signal a_w_low_index2 : STD_LOGIC_VECTOR(15 downto 0);
signal a_w_low_index3 : STD_LOGIC_VECTOR(15 downto 0);
signal const_hw : STD_LOGIC_VECTOR(15 downto 0);
signal result_w_index0 : STD_LOGIC_VECTOR(31 downto 0);
signal result_w_index1 : STD_LOGIC_VECTOR(31 downto 0);
signal result_w_index2 : STD_LOGIC_VECTOR(31 downto 0);
signal result_w_index3 : STD_LOGIC_VECTOR(31 downto 0);

begin

---- User Signal Assignments ----
a_w_low_index3 <= input_a(111 downto 96);
a_w_low_index2 <= input_a(79 downto 64);
a_w_low_index1 <= input_a(47 downto 32);
a_w_low_index0 <= input_a(15 downto 0);
const_hw <= "00000000000" & input_const;
result_w_index3 <= std_logic_vector(resize((unsigned(a_w_low_index3) * unsigned(const_hw)),32));
result_w_index2 <= std_logic_vector(resize((unsigned(a_w_low_index2) * unsigned(const_hw)),32));
result_w_index1 <= std_logic_vector(resize((unsigned(a_w_low_index1) * unsigned(const_hw)),32));
result_w_index0 <= std_logic_vector(resize((unsigned(a_w_low_index0) * unsigned(const_hw)),32));
output_result <= result_w_index3 & result_w_index2 & result_w_index1 & result_w_index0;

end MLHCU;
