-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\compile\SFHS.vhd
-- Generated   : Sat Nov 30 22:50:46 2024
-- From        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\..\SFHS.bde
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

entity SFHS is
  port(
       input_a : in STD_LOGIC_VECTOR(127 downto 0);
       input_b : in STD_LOGIC_VECTOR(127 downto 0);
       output_result : out STD_LOGIC_VECTOR(127 downto 0)
  );
end SFHS;

architecture SFHS of SFHS is

---- Architecture declarations -----
constant MAX : integer := 32767;
constant MIN : integer := - 32768;
constant MAX_result : std_logic_vector(31 downto 0) := X"00007FFF";
constant MIN_result : std_logic_vector(31 downto 0) := X"00008000";



begin

---- Processes ----

process (input_a(15 downto 0),input_a(31 downto 16),input_a(47 downto 32),input_a(63 downto 48),input_a(79 downto 64),input_a(95 downto 80),input_a(111 downto 96),input_a(127 downto 112),input_b(15 downto 0),input_b(31 downto 16),input_b(47 downto 32),input_b(63 downto 48),input_b(79 downto 64),input_b(95 downto 80),input_b(111 downto 96),input_b(127 downto 112))
                         variable a_long_index7 : std_logic_vector(31 downto 0);
                         variable a_long_index6 : std_logic_vector(31 downto 0);
                         variable a_long_index5 : std_logic_vector(31 downto 0);
                         variable a_long_index4 : std_logic_vector(31 downto 0);
                         variable a_long_index3 : std_logic_vector(31 downto 0);
                         variable a_long_index2 : std_logic_vector(31 downto 0);
                         variable a_long_index1 : std_logic_vector(31 downto 0);
                         variable a_long_index0 : std_logic_vector(31 downto 0);
                         variable b_long_index7 : std_logic_vector(31 downto 0);
                         variable b_long_index6 : std_logic_vector(31 downto 0);
                         variable b_long_index5 : std_logic_vector(31 downto 0);
                         variable b_long_index4 : std_logic_vector(31 downto 0);
                         variable b_long_index3 : std_logic_vector(31 downto 0);
                         variable b_long_index2 : std_logic_vector(31 downto 0);
                         variable b_long_index1 : std_logic_vector(31 downto 0);
                         variable b_long_index0 : std_logic_vector(31 downto 0);
                         variable result_long_index7 : std_logic_vector(31 downto 0);
                         variable result_long_index6 : std_logic_vector(31 downto 0);
                         variable result_long_index5 : std_logic_vector(31 downto 0);
                         variable result_long_index4 : std_logic_vector(31 downto 0);
                         variable result_long_index3 : std_logic_vector(31 downto 0);
                         variable result_long_index2 : std_logic_vector(31 downto 0);
                         variable result_long_index1 : std_logic_vector(31 downto 0);
                         variable result_long_index0 : std_logic_vector(31 downto 0);
                         variable result_index7 : std_logic_vector(15 downto 0);
                         variable result_index6 : std_logic_vector(15 downto 0);
                         variable result_index5 : std_logic_vector(15 downto 0);
                         variable result_index4 : std_logic_vector(15 downto 0);
                         variable result_index3 : std_logic_vector(15 downto 0);
                         variable result_index2 : std_logic_vector(15 downto 0);
                         variable result_index1 : std_logic_vector(15 downto 0);
                         variable result_index0 : std_logic_vector(15 downto 0);
                       begin
                         a_long_index7 := std_logic_vector(resize(signed(input_a(127 downto 112)),32));
                         a_long_index6 := std_logic_vector(resize(signed(input_a(111 downto 96)),32));
                         a_long_index5 := std_logic_vector(resize(signed(input_a(95 downto 80)),32));
                         a_long_index4 := std_logic_vector(resize(signed(input_a(79 downto 64)),32));
                         a_long_index3 := std_logic_vector(resize(signed(input_a(63 downto 48)),32));
                         a_long_index2 := std_logic_vector(resize(signed(input_a(47 downto 32)),32));
                         a_long_index1 := std_logic_vector(resize(signed(input_a(31 downto 16)),32));
                         a_long_index0 := std_logic_vector(resize(signed(input_a(15 downto 0)),32));
                         b_long_index7 := std_logic_vector(resize(signed(input_b(127 downto 112)),32));
                         b_long_index6 := std_logic_vector(resize(signed(input_b(111 downto 96)),32));
                         b_long_index5 := std_logic_vector(resize(signed(input_b(95 downto 80)),32));
                         b_long_index4 := std_logic_vector(resize(signed(input_b(79 downto 64)),32));
                         b_long_index3 := std_logic_vector(resize(signed(input_b(63 downto 48)),32));
                         b_long_index2 := std_logic_vector(resize(signed(input_b(47 downto 32)),32));
                         b_long_index1 := std_logic_vector(resize(signed(input_b(31 downto 16)),32));
                         b_long_index0 := std_logic_vector(resize(signed(input_b(15 downto 0)),32));
                         result_long_index7 := std_logic_vector(signed(a_long_index7) - signed(b_long_index7));
                         result_long_index6 := std_logic_vector(signed(a_long_index6) - signed(b_long_index6));
                         result_long_index5 := std_logic_vector(signed(a_long_index5) - signed(b_long_index5));
                         result_long_index4 := std_logic_vector(signed(a_long_index4) - signed(b_long_index4));
                         result_long_index3 := std_logic_vector(signed(a_long_index3) - signed(b_long_index3));
                         result_long_index2 := std_logic_vector(signed(a_long_index2) - signed(b_long_index2));
                         result_long_index1 := std_logic_vector(signed(a_long_index1) - signed(b_long_index1));
                         result_long_index0 := std_logic_vector(signed(a_long_index0) - signed(b_long_index0));
                         if (signed(result_long_index7) > MAX) then
                            result_long_index7 := MAX_result;
                         elsif (signed(result_long_index7) < MIN) then
                            result_long_index7 := MIN_result;
                         end if;
                         if (signed(result_long_index6) > MAX) then
                            result_long_index6 := MAX_result;
                         elsif (signed(result_long_index6) < MIN) then
                            result_long_index6 := MIN_result;
                         end if;
                         if (signed(result_long_index5) > MAX) then
                            result_long_index5 := MAX_result;
                         elsif (signed(result_long_index5) < MIN) then
                            result_long_index5 := MIN_result;
                         end if;
                         if (signed(result_long_index4) > MAX) then
                            result_long_index4 := MAX_result;
                         elsif (signed(result_long_index4) < MIN) then
                            result_long_index4 := MIN_result;
                         end if;
                         if (signed(result_long_index3) > MAX) then
                            result_long_index3 := MAX_result;
                         elsif (signed(result_long_index3) < MIN) then
                            result_long_index3 := MIN_result;
                         end if;
                         if (signed(result_long_index2) > MAX) then
                            result_long_index2 := MAX_result;
                         elsif (signed(result_long_index2) < MIN) then
                            result_long_index2 := MIN_result;
                         end if;
                         if (signed(result_long_index1) > MAX) then
                            result_long_index1 := MAX_result;
                         elsif (signed(result_long_index1) < MIN) then
                            result_long_index1 := MIN_result;
                         end if;
                         if (signed(result_long_index0) > MAX) then
                            result_long_index0 := MAX_result;
                         elsif (signed(result_long_index0) < MIN) then
                            result_long_index0 := MIN_result;
                         end if;
                         result_index7 := result_long_index7(15 downto 0);
                         result_index6 := result_long_index6(15 downto 0);
                         result_index5 := result_long_index5(15 downto 0);
                         result_index4 := result_long_index4(15 downto 0);
                         result_index3 := result_long_index3(15 downto 0);
                         result_index2 := result_long_index2(15 downto 0);
                         result_index1 := result_long_index1(15 downto 0);
                         result_index0 := result_long_index0(15 downto 0);
                         output_result <= result_index7 & result_index6 & result_index5 & result_index4 & result_index3 & result_index2 & result_index1 & result_index0;
                       end process;
                      

end SFHS;
