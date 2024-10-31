-------------------------------------------------------------------------------
--
-- Description : Signed Integer Multiply Subtract High with Saturation 
--
-------------------------------------------------------------------------------	
library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;

entity Signed_Integer_Multiply_Subtract_High_w_Saturation is
	port(
		rs1 : in STD_LOGIC_VECTOR(127 downto 0);
		rs2 : in STD_LOGIC_VECTOR(127 downto 0);
		rs3 : in STD_LOGIC_VECTOR(127 downto 0);   
		rd : out STD_LOGIC_VECTOR(127 downto 0)
		);
end Signed_Integer_Multiply_Subtract_High_w_Saturation;

architecture behavioral of Signed_Integer_Multiply_Subtract_High_w_Saturation is
begin
	process(all)
	variable temp_reg: std_logic_vector(127 downto 0);
	variable over_under_flow: signed(32 downto 0);
	variable max_val_32: signed(31 downto 0) := signed(b"01111111111111111111111111111111");
	variable min_val_32: signed(31 downto 0) := signed(b"10000000000000000000000000000000");

	begin
		temp_reg(31 downto 0) := std_logic_vector(signed(rs2(31 downto 16)) * signed(rs3(31 downto 16))); --first 16-bit field

		over_under_flow := resize(signed(rs1(31 downto 0)), 33) - resize(signed(temp_reg(31 downto 0)),33);
		if(over_under_flow >= max_val_32) then
			rd(31 downto 0) <= std_logic_vector(max_val_32);
		elsif(over_under_flow <= min_val_32) then
			rd(31 downto 0) <= std_logic_vector(min_val_32);
		else
			rd(31 downto 0) <= std_logic_vector(signed(rs1(31 downto 0)) - signed(temp_reg(31 downto 0)));
		end if;
----------------------------------------------------------------------------------------------------------------------------------------------------------
		temp_reg(63 downto 32) := std_logic_vector(signed(rs2(63 downto 48)) * signed(rs3(63 downto 48)));  --second 16-bit field

		over_under_flow := resize(signed(rs1(63 downto 32)), 33) - resize(signed(temp_reg(63 downto 32)),33);
		if(over_under_flow >= max_val_32) then
			rd(63 downto 32) <= std_logic_vector(max_val_32);
		elsif(over_under_flow <= min_val_32) then
			rd(63 downto 32) <= std_logic_vector(min_val_32);
		else
			rd(63 downto 32) <= std_logic_vector(signed(rs1(63 downto 32)) - signed(temp_reg(63 downto 32)));
		end if;
----------------------------------------------------------------------------------------------------------------------------------------------------------
		temp_reg(95 downto 64) := std_logic_vector(signed(rs2(95 downto 80)) * signed(rs3(95 downto 80)));  --third 16-bit field

		over_under_flow := resize(signed(rs1(95 downto 64)), 33) - resize(signed(temp_reg(95 downto 64)),33);
		if(over_under_flow >= max_val_32) then
			rd(95 downto 64) <= std_logic_vector(max_val_32);
		elsif(over_under_flow <= min_val_32) then
			rd(95 downto 64) <= std_logic_vector(min_val_32);
		else
			rd(95 downto 64) <= std_logic_vector(signed(rs1(95 downto 64)) - signed(temp_reg(95 downto 64)));
		end if;
----------------------------------------------------------------------------------------------------------------------------------------------------------
		temp_reg(127 downto 96) := std_logic_vector(signed(rs2(127 downto 112)) * signed(rs3(127 downto 112)));  --fourth 16-bit field

		over_under_flow := resize(signed(rs1(127 downto 96)), 33) - resize(signed(temp_reg(127 downto 96)),33);
		if(over_under_flow >= max_val_32) then
			rd(127 downto 96) <= std_logic_vector(max_val_32);
		elsif(over_under_flow <= min_val_32) then
			rd(127 downto 96) <= std_logic_vector(min_val_32);
		else
			rd(127 downto 96) <= std_logic_vector(signed(rs1(127 downto 96)) - signed(temp_reg(127 downto 96)));
		end if;
	end process;
end behavioral;