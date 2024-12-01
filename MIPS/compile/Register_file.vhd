-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\compile\Register_file.vhd
-- Generated   : Sat Nov 30 22:50:44 2024
-- From        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\..\Register_file.bde
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

entity Register_file is
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       instruction : in STD_LOGIC_VECTOR(24 downto 0);
       reg_write_en : in STD_LOGIC;
       reg_write_addr : in STD_LOGIC_VECTOR(4 downto 0);
       reg_write_data : in STD_LOGIC_VECTOR(127 downto 0);
       reg_read_addr1 : in STD_LOGIC_VECTOR(4 downto 0);
       reg_read_addr2 : in STD_LOGIC_VECTOR(4 downto 0);
       reg_read_addr3 : in STD_LOGIC_VECTOR(4 downto 0);
       reg_read_data1 : out STD_LOGIC_VECTOR(127 downto 0);
       reg_read_data2 : out STD_LOGIC_VECTOR(127 downto 0);
       reg_read_data3 : out STD_LOGIC_VECTOR(127 downto 0);
       reg_rs1_addr_out : out STD_LOGIC_VECTOR(4 downto 0);
       reg_rs2_addr_out : out STD_LOGIC_VECTOR(4 downto 0);
       reg_rs3_addr_out : out STD_LOGIC_VECTOR(4 downto 0);
       instr_opcode : out STD_LOGIC_VECTOR(9 downto 0);
       instr_imme : out STD_LOGIC_VECTOR(15 downto 0);
       instr_rd : out STD_LOGIC_VECTOR(4 downto 0);
       write_en_out : out STD_LOGIC;
       load_flag_out : out STD_LOGIC
  );
end Register_file;

architecture Register_file of Register_file is

---- Architecture declarations -----
--Added by Active-HDL. Do not change code inside this section.
type register_file is array (0 to 31) of STD_LOGIC_VECTOR(127 downto 0);
--End of extra code.


---- Signal declarations used on the diagram ----

signal reg_file : register_file;

begin

---- Processes ----

process (clk,rst)
                       begin
                         if rst = '1' then
                            for i in 0 to 31 loop
                                reg_file(i) <= (others => '0');
                            end loop;
                         elsif rising_edge(clk) then
                            if reg_write_en = '1' then
                               reg_file(to_integer(unsigned(reg_write_addr))) <= reg_write_data;
                               if (reg_write_addr = reg_read_addr1) then
                                  reg_read_data1 <= reg_write_data;
                               end if;
                               if (reg_write_addr = reg_read_addr2) then
                                  reg_read_data2 <= reg_write_data;
                               end if;
                               if (reg_write_addr = reg_read_addr3) then
                                  reg_read_data3 <= reg_write_data;
                               end if;
                               if (instr_opcode(3 downto 0) = "0000") then
                                  write_en_out <= '0';
                               else 
                                  write_en_out <= '1';
                               end if;
                            else 
                               reg_read_data1 <= reg_file(to_integer(unsigned(reg_read_addr1)));
                               reg_read_data2 <= reg_file(to_integer(unsigned(reg_read_addr2)));
                               reg_read_data3 <= reg_file(to_integer(unsigned(reg_read_addr3)));
                            end if;
                            if (instr_opcode(9) = '0') then
                               load_flag_out <= '1';
                            else 
                               load_flag_out <= '0';
                            end if;
                            instr_opcode <= instruction(24 downto 15);
                            instr_imme <= instruction(20 downto 5);
                            instr_rd <= instruction(4 downto 0);
                            reg_rs1_addr_out <= reg_read_addr1;
                            reg_rs2_addr_out <= reg_read_addr2;
                            reg_rs3_addr_out <= reg_read_addr3;
                         end if;
                       end process;
                      

end Register_file;
