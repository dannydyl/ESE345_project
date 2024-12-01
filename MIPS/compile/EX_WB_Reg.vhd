-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\compile\EX_WB_Reg.vhd
-- Generated   : Sat Nov 30 22:50:30 2024
-- From        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\..\EX_WB_Reg.bde
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

entity EX_WB_Reg is
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       rd_address_in : in STD_LOGIC_VECTOR(4 downto 0);
       rd_in : in STD_LOGIC_VECTOR(127 downto 0);
       write_en_in : in STD_LOGIC;
       rd_address_out : out STD_LOGIC_VECTOR(4 downto 0);
       rd_out : out STD_LOGIC_VECTOR(127 downto 0);
       write_en_out : out STD_LOGIC
  );
end EX_WB_Reg;

architecture behavior of EX_WB_Reg is

begin

---- Processes ----

process (clk,rst)
                       begin
                         if rst = '1' then
                            rd_address_out <= (others => '0');
                            rd_out <= std_logic_vector(to_unsigned(0,128));
                            write_en_out <= '0';
                         elsif rising_edge(clk) then
                            rd_address_out <= rd_address_in;
                            rd_out <= rd_in;
                            write_en_out <= write_en_in;
                         end if;
                       end process;
                      

end behavior;
