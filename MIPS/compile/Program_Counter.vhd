-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\compile\Program_Counter.vhd
-- Generated   : Sat Nov 30 22:50:40 2024
-- From        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\..\Program_Counter.bde
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

entity Program_Counter is
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       PC_out : out STD_LOGIC_VECTOR(5 downto 0)
  );
end Program_Counter;

architecture Program_Counter of Program_Counter is

---- Signal declarations used on the diagram ----

signal counter : UNSIGNED(5 downto 0);

begin

---- Processes ----

process (clk,rst)
                       begin
                         if rst = '1' then
                            counter <= (others => '0');
                         elsif rising_edge(clk) then
                            counter <= counter + 1;
                         end if;
                       end process;
                      

---- User Signal Assignments ----
PC_out <= std_logic_vector(counter);

end Program_Counter;
