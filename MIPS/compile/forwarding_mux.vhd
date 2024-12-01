-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\compile\forwarding_mux.vhd
-- Generated   : Sat Nov 30 22:50:30 2024
-- From        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\..\forwarding_mux.bde
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

entity forwarding_mux is
  port(
       rs1_reg : in STD_LOGIC_VECTOR(127 downto 0);
       rs2_reg : in STD_LOGIC_VECTOR(127 downto 0);
       rs3_reg : in STD_LOGIC_VECTOR(127 downto 0);
       rd_EX_WB : in STD_LOGIC_VECTOR(127 downto 0);
       rs1_select : in STD_LOGIC;
       rs2_select : in STD_LOGIC;
       rs3_select : in STD_LOGIC;
       rs1 : out STD_LOGIC_VECTOR(127 downto 0);
       rs2 : out STD_LOGIC_VECTOR(127 downto 0);
       rs3 : out STD_LOGIC_VECTOR(127 downto 0)
  );
end forwarding_mux;

architecture behavioral of forwarding_mux is

begin

---- Processes ----

process (rs1_reg,rs2_reg,rs3_reg,rd_EX_WB,rs1_select,rs2_select,rs3_select)
                       begin
                         if rs1_select = '1' then
                            rs1 <= rd_EX_WB;
                         else 
                            rs1 <= rs1_reg;
                         end if;
                         if rs2_select = '1' then
                            rs2 <= rd_EX_WB;
                         else 
                            rs2 <= rs2_reg;
                         end if;
                         if rs3_select = '1' then
                            rs3 <= rd_EX_WB;
                         else 
                            rs3 <= rs3_reg;
                         end if;
                       end process;
                      

end behavioral;
