-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\compile\forwarding_unit.vhd
-- Generated   : Sat Nov 30 22:50:31 2024
-- From        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\..\forwarding_unit.bde
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

entity forwarding_unit is
  port(
       instruction_WB : in STD_LOGIC_VECTOR(4 downto 0);
       rd_addr_EX : in STD_LOGIC_VECTOR(4 downto 0);
       rs1_addr_EX : in STD_LOGIC_VECTOR(4 downto 0);
       rs2_addr_EX : in STD_LOGIC_VECTOR(4 downto 0);
       rs3_addr_EX : in STD_LOGIC_VECTOR(4 downto 0);
       write_en_EX : in STD_LOGIC;
       load_flag_in : in STD_LOGIC;
       rs1_select : out STD_LOGIC;
       rs2_select : out STD_LOGIC;
       rs3_select : out STD_LOGIC
  );
end forwarding_unit;

architecture behavioral of forwarding_unit is

begin

---- Processes ----

process (instruction_WB,rd_addr_EX,rs1_addr_EX,rs2_addr_EX,rs3_addr_EX,write_en_EX,load_flag_in)
                         variable forward_enable : std_logic;
                       begin
                         if write_en_EX = '0' then
                            forward_enable := '0';
                         else 
                            forward_enable := '1';
                         end if;
                         if load_flag_in = '0' and instruction_WB = rd_addr_EX and forward_enable = '1' then
                            rs1_select <= '1';
                         else 
                            rs1_select <= '0';
                         end if;
                         if instruction_WB = rs1_addr_EX and forward_enable = '1' then
                            rs1_select <= '1';
                         else 
                            rs1_select <= '0';
                         end if;
                         if instruction_WB = rs2_addr_EX and forward_enable = '1' then
                            rs2_select <= '1';
                         else 
                            rs2_select <= '0';
                         end if;
                         if instruction_WB = rs3_addr_EX and forward_enable = '1' then
                            rs3_select <= '1';
                         else 
                            rs3_select <= '0';
                         end if;
                       end process;
                      

end behavioral;
