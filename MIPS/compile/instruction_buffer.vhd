-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\compile\instruction_buffer.vhd
-- Generated   : Sat Nov 30 22:50:33 2024
-- From        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\..\instruction_buffer.bde
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

entity instruction_buffer is
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       load_en : in STD_LOGIC;
       instruction_in : in STD_LOGIC_VECTOR(24 downto 0);
       instruction_out : out STD_LOGIC_VECTOR(24 downto 0)
  );
end instruction_buffer;

architecture behavioral of instruction_buffer is

---- Component declarations -----

component Program_Counter
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       PC_out : out STD_LOGIC_VECTOR(5 downto 0)
  );
end component;

---- Architecture declarations -----
constant line_length : integer := 64;
--Added by Active-HDL. Do not change code inside this section.
type instruction_buffer is array (0 to line_length - 1) of STD_LOGIC_VECTOR(24 downto 0);
--End of extra code.


---- Signal declarations used on the diagram ----

signal instr_buffer : instruction_buffer;
signal PC_current : STD_LOGIC_VECTOR(5 downto 0);

begin

---- Processes ----

process (clk)
                       begin
                         if rising_edge(clk) then
                            if load_en = '1' then
                               instr_buffer(to_integer(unsigned(PC_current))) <= instruction_in;
                            end if;
                         end if;
                       end process;
                      

process (clk)
                       begin
                         if rising_edge(clk) then
                            instruction_out <= instr_buffer(to_integer(unsigned(PC_current)));
                         end if;
                       end process;
                      

----  Component instantiations  ----

PC_inst : Program_Counter
  port map(
       clk => clk,
       rst => rst,
       PC_out => PC_current
  );


end behavioral;
