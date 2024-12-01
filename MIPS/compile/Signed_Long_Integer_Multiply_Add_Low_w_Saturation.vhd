-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\compile\Signed_Long_Integer_Multiply_Add_Low_w_Saturation.vhd
-- Generated   : Sat Nov 30 22:50:49 2024
-- From        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\..\Signed_Long_Integer_Multiply_Add_Low_w_Saturation.bde
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

entity Signed_Long_Integer_Multiply_Add_Low_w_Saturation is
  port(
       rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       rs3 : in STD_LOGIC_VECTOR(127 downto 0);
       rd : out STD_LOGIC_VECTOR(127 downto 0)
  );
end Signed_Long_Integer_Multiply_Add_Low_w_Saturation;

architecture behavioral of Signed_Long_Integer_Multiply_Add_Low_w_Saturation is

begin

---- Processes ----

process (rs1(127 downto 64),rs1(63 downto 0),rs2(95 downto 64),rs2(31 downto 0),rs3(95 downto 64),rs3(31 downto 0))
                         variable temp_reg : std_logic_vector(127 downto 0);
                         variable over_under_flow : signed(64 downto 0);
                         variable max_val_64 : signed(63 downto 0) := signed(b"0111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111");
                         variable min_val_64 : signed(63 downto 0) := signed(b"1000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000");
                       begin
                         temp_reg(63 downto 0) := std_logic_vector(signed(rs2(31 downto 0)) * signed(rs3(31 downto 0)));
                         over_under_flow := resize(signed(rs1(63 downto 0)),65) + resize(signed(temp_reg(63 downto 0)),65);
                         if (over_under_flow >= max_val_64) then
                            rd(63 downto 0) <= std_logic_vector(max_val_64);
                         elsif (over_under_flow <= min_val_64) then
                            rd(63 downto 0) <= std_logic_vector(min_val_64);
                         else 
                            rd(63 downto 0) <= std_logic_vector(signed(rs1(63 downto 0)) + signed(temp_reg(63 downto 0)));
                         end if;
                         temp_reg(127 downto 64) := std_logic_vector(signed(rs2(95 downto 64)) * signed(rs3(95 downto 64)));
                         over_under_flow := resize(signed(rs1(127 downto 64)),65) + resize(signed(temp_reg(127 downto 64)),65);
                         if (over_under_flow >= max_val_64) then
                            rd(127 downto 64) <= std_logic_vector(max_val_64);
                         elsif (over_under_flow <= min_val_64) then
                            rd(127 downto 64) <= std_logic_vector(min_val_64);
                         else 
                            rd(127 downto 64) <= std_logic_vector(signed(rs1(127 downto 64)) + signed(temp_reg(127 downto 64)));
                         end if;
                       end process;
                      

end behavioral;
