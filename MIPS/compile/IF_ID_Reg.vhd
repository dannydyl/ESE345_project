-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\compile\IF_ID_Reg.vhd
-- Generated   : Sat Nov 30 22:50:32 2024
-- From        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\..\IF_ID_Reg.bde
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

entity IF_ID_Reg is
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       instruction_in : in STD_LOGIC_VECTOR(24 downto 0);
       instruction_out : out STD_LOGIC_VECTOR(24 downto 0)
  );
end IF_ID_Reg;

architecture behavioral of IF_ID_Reg is

begin

---- Processes ----

process (clk,rst)
                       begin
                         if rst = '1' then
                            instruction_out <= (others => '0');
                         elsif rising_edge(clk) then
                            instruction_out <= instruction_in;
                         end if;
                       end process;
                      

end behavioral;
