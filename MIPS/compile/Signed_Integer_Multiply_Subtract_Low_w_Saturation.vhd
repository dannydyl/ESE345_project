-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\compile\Signed_Integer_Multiply_Subtract_Low_w_Saturation.vhd
-- Generated   : Sat Nov 30 22:50:48 2024
-- From        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\..\Signed_Integer_Multiply_Subtract_Low_w_Saturation.bde
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

entity Signed_Integer_Multiply_Subtract_Low_w_Saturation is
  port(
       rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       rs3 : in STD_LOGIC_VECTOR(127 downto 0);
       rd : out STD_LOGIC_VECTOR(127 downto 0)
  );
end Signed_Integer_Multiply_Subtract_Low_w_Saturation;

architecture behavioral of Signed_Integer_Multiply_Subtract_Low_w_Saturation is

begin

---- Processes ----

process (rs1(127 downto 96),rs1(95 downto 64),rs1(63 downto 32),rs1(31 downto 0),rs2(111 downto 96),rs2(79 downto 64),rs2(47 downto 32),rs2(15 downto 0),rs3(111 downto 96),rs3(79 downto 64),rs3(47 downto 32),rs3(15 downto 0))
                         variable temp_reg : std_logic_vector(127 downto 0);
                         variable over_under_flow : signed(32 downto 0);
                         variable max_val_32 : signed(31 downto 0) := signed(b"01111111111111111111111111111111");
                         variable min_val_32 : signed(31 downto 0) := signed(b"10000000000000000000000000000000");
                       begin
                         temp_reg(31 downto 0) := std_logic_vector(signed(rs2(15 downto 0)) * signed(rs3(15 downto 0)));
                         over_under_flow := resize(signed(rs1(31 downto 0)),33) - resize(signed(temp_reg(31 downto 0)),33);
                         if (over_under_flow >= max_val_32) then
                            rd(31 downto 0) <= std_logic_vector(max_val_32);
                         elsif (over_under_flow <= min_val_32) then
                            rd(31 downto 0) <= std_logic_vector(min_val_32);
                         else 
                            rd(31 downto 0) <= std_logic_vector(signed(rs1(31 downto 0)) - signed(temp_reg(31 downto 0)));
                         end if;
                         temp_reg(63 downto 32) := std_logic_vector(signed(rs2(47 downto 32)) * signed(rs3(47 downto 32)));
                         over_under_flow := resize(signed(rs1(63 downto 32)),33) - resize(signed(temp_reg(63 downto 32)),33);
                         if (over_under_flow >= max_val_32) then
                            rd(63 downto 32) <= std_logic_vector(max_val_32);
                         elsif (over_under_flow <= min_val_32) then
                            rd(63 downto 32) <= std_logic_vector(min_val_32);
                         else 
                            rd(63 downto 32) <= std_logic_vector(signed(rs1(63 downto 32)) - signed(temp_reg(63 downto 32)));
                         end if;
                         temp_reg(95 downto 64) := std_logic_vector(signed(rs2(79 downto 64)) * signed(rs3(79 downto 64)));
                         over_under_flow := resize(signed(rs1(95 downto 64)),33) - resize(signed(temp_reg(95 downto 64)),33);
                         if (over_under_flow >= max_val_32) then
                            rd(95 downto 64) <= std_logic_vector(max_val_32);
                         elsif (over_under_flow <= min_val_32) then
                            rd(95 downto 64) <= std_logic_vector(min_val_32);
                         else 
                            rd(95 downto 64) <= std_logic_vector(signed(rs1(95 downto 64)) - signed(temp_reg(95 downto 64)));
                         end if;
                         temp_reg(127 downto 96) := std_logic_vector(signed(rs2(111 downto 96)) * signed(rs3(111 downto 96)));
                         over_under_flow := resize(signed(rs1(127 downto 96)),33) - resize(signed(temp_reg(127 downto 96)),33);
                         if (over_under_flow >= max_val_32) then
                            rd(127 downto 96) <= std_logic_vector(max_val_32);
                         elsif (over_under_flow <= min_val_32) then
                            rd(127 downto 96) <= std_logic_vector(min_val_32);
                         else 
                            rd(127 downto 96) <= std_logic_vector(signed(rs1(127 downto 96)) - signed(temp_reg(127 downto 96)));
                         end if;
                       end process;
                      

end behavioral;
