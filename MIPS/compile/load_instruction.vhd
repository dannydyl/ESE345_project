-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\compile\load_instruction.vhd
-- Generated   : Sat Nov 30 22:50:34 2024
-- From        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\..\load_instruction.bde
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

entity load_instruction is
  port(
       old_rd : in STD_LOGIC_VECTOR(127 downto 0);
       load_index : in STD_LOGIC_VECTOR(2 downto 0);
       immediate : in STD_LOGIC_VECTOR(15 downto 0);
       new_rd : out STD_LOGIC_VECTOR(127 downto 0)
  );
end load_instruction;

architecture behavioral of load_instruction is

begin

---- Processes ----

process (old_rd,load_index,immediate)
                         variable temp_reg : std_logic_vector(127 downto 0);
                       begin
                         temp_reg := old_rd;
                         case load_index is 
                           when "000" => 
                              temp_reg(15 downto 0) := immediate;
                           when "001" => 
                              temp_reg(31 downto 16) := immediate;
                           when "010" => 
                              temp_reg(47 downto 32) := immediate;
                           when "011" => 
                              temp_reg(63 downto 48) := immediate;
                           when "100" => 
                              temp_reg(79 downto 64) := immediate;
                           when "101" => 
                              temp_reg(95 downto 80) := immediate;
                           when "110" => 
                              temp_reg(111 downto 96) := immediate;
                           when "111" => 
                              temp_reg(127 downto 112) := immediate;
                           when others => 
                              null;
                         end case;
                         new_rd <= temp_reg;
                       end process;
                      

end behavioral;
