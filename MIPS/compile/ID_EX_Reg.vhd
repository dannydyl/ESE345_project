-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\compile\ID_EX_Reg.vhd
-- Generated   : Sat Nov 30 22:50:31 2024
-- From        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\..\ID_EX_Reg.bde
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

entity ID_EX_Reg is
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       instr_opcode_in : in STD_LOGIC_VECTOR(9 downto 0);
       instr_imme_in : in STD_LOGIC_VECTOR(15 downto 0);
       instr_rd_in : in STD_LOGIC_VECTOR(4 downto 0);
       rs1_data_in : in STD_LOGIC_VECTOR(127 downto 0);
       rs2_data_in : in STD_LOGIC_VECTOR(127 downto 0);
       rs3_data_in : in STD_LOGIC_VECTOR(127 downto 0);
       rs1_addr_in : in STD_LOGIC_VECTOR(4 downto 0);
       rs2_addr_in : in STD_LOGIC_VECTOR(4 downto 0);
       rs3_addr_in : in STD_LOGIC_VECTOR(4 downto 0);
       write_en_in : in STD_LOGIC;
       load_flag_in : in STD_LOGIC;
       instr_opcode_out : out STD_LOGIC_VECTOR(9 downto 0);
       instr_imme_out : out STD_LOGIC_VECTOR(15 downto 0);
       instr_rd_out : out STD_LOGIC_VECTOR(4 downto 0);
       rs1_data_out : out STD_LOGIC_VECTOR(127 downto 0);
       rs2_data_out : out STD_LOGIC_VECTOR(127 downto 0);
       rs3_data_out : out STD_LOGIC_VECTOR(127 downto 0);
       rs1_addr_out : out STD_LOGIC_VECTOR(4 downto 0);
       rs2_addr_out : out STD_LOGIC_VECTOR(4 downto 0);
       rs3_addr_out : out STD_LOGIC_VECTOR(4 downto 0);
       write_en_out : out STD_LOGIC;
       load_flag_out : out STD_LOGIC
  );
end ID_EX_Reg;

architecture behavioral of ID_EX_Reg is

begin

---- Processes ----

process (clk,rst)
                       begin
                         if rst = '1' then
                            instr_opcode_out <= (others => '0');
                            instr_imme_out <= (others => '0');
                            instr_rd_out <= (others => '0');
                            rs1_data_out <= (others => '0');
                            rs2_data_out <= (others => '0');
                            rs3_data_out <= (others => '0');
                            rs1_addr_out <= (others => '0');
                            rs2_addr_out <= (others => '0');
                            rs3_addr_out <= (others => '0');
                            write_en_out <= '0';
                            load_flag_out <= '0';
                         elsif rising_edge(clk) then
                            instr_opcode_out <= instr_opcode_in;
                            instr_imme_out <= instr_imme_in;
                            instr_rd_out <= instr_rd_in;
                            rs1_data_out <= rs1_data_in;
                            rs2_data_out <= rs2_data_in;
                            rs3_data_out <= rs3_data_in;
                            rs1_addr_out <= rs1_addr_in;
                            rs2_addr_out <= rs2_addr_in;
                            rs3_addr_out <= rs3_addr_in;
                            write_en_out <= write_en_in;
                            load_flag_out <= load_flag_in;
                         end if;
                       end process;
                      

end behavioral;
