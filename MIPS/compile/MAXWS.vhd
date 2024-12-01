-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\compile\MAXWS.vhd
-- Generated   : Sat Nov 30 22:50:34 2024
-- From        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\..\MAXWS.bde
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

entity MAXWS is
  port(
       input_a : in STD_LOGIC_VECTOR(127 downto 0);
       input_b : in STD_LOGIC_VECTOR(127 downto 0);
       output_result : out STD_LOGIC_VECTOR(127 downto 0)
  );
end MAXWS;

architecture MAXWS of MAXWS is

---- Signal declarations used on the diagram ----

signal a_w_index0 : STD_LOGIC_VECTOR(31 downto 0);
signal a_w_index1 : STD_LOGIC_VECTOR(31 downto 0);
signal a_w_index2 : STD_LOGIC_VECTOR(31 downto 0);
signal a_w_index3 : STD_LOGIC_VECTOR(31 downto 0);
signal b_w_index0 : STD_LOGIC_VECTOR(31 downto 0);
signal b_w_index1 : STD_LOGIC_VECTOR(31 downto 0);
signal b_w_index2 : STD_LOGIC_VECTOR(31 downto 0);
signal b_w_index3 : STD_LOGIC_VECTOR(31 downto 0);
signal result_w_index0 : STD_LOGIC_VECTOR(31 downto 0);
signal result_w_index1 : STD_LOGIC_VECTOR(31 downto 0);
signal result_w_index2 : STD_LOGIC_VECTOR(31 downto 0);
signal result_w_index3 : STD_LOGIC_VECTOR(31 downto 0);

begin

---- Processes ----

process (a_w_index3,b_w_index3)
                       begin
                         if (signed(a_w_index3) > signed(b_w_index3)) then
                            result_w_index3 <= a_w_index3;
                         else 
                            result_w_index3 <= b_w_index3;
                         end if;
                       end process;
                      

process (a_w_index2,b_w_index2)
                       begin
                         if (signed(a_w_index2) > signed(b_w_index2)) then
                            result_w_index2 <= a_w_index2;
                         else 
                            result_w_index2 <= b_w_index2;
                         end if;
                       end process;
                      

process (a_w_index1,b_w_index1)
                       begin
                         if (signed(a_w_index1) > signed(b_w_index1)) then
                            result_w_index1 <= a_w_index1;
                         else 
                            result_w_index1 <= b_w_index1;
                         end if;
                       end process;
                      

process (a_w_index0,b_w_index0)
                       begin
                         if (signed(a_w_index0) > signed(b_w_index0)) then
                            result_w_index0 <= a_w_index0;
                         else 
                            result_w_index0 <= b_w_index0;
                         end if;
                       end process;
                      

---- User Signal Assignments ----
a_w_index3 <= input_a(127 downto 96);
a_w_index2 <= input_a(95 downto 64);
a_w_index1 <= input_a(63 downto 32);
a_w_index0 <= input_a(31 downto 0);
b_w_index3 <= input_b(127 downto 96);
b_w_index2 <= input_b(95 downto 64);
b_w_index1 <= input_b(63 downto 32);
b_w_index0 <= input_b(31 downto 0);
output_result <= result_w_index3 & result_w_index2 & result_w_index1 & result_w_index0;

end MAXWS;
