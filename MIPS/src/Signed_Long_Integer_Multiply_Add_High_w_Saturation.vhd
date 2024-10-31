--
-- Description :Signed Long Integer Multiply Add High with Saturation
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Signed_Long_Integer_Multiply_Add_High_w_Saturation is
	port(
		rs1 : in STD_LOGIC_VECTOR(127 downto 0);
		rs2 : in STD_LOGIC_VECTOR(127 downto 0);
		rs3 : in STD_LOGIC_VECTOR(127 downto 0);   
		rd : out STD_LOGIC_VECTOR(127 downto 0)
	);
end Signed_Long_Integer_Multiply_Add_High_w_Saturation;


architecture behavioral of Signed_Long_Integer_Multiply_Add_High_w_Saturation is 
begin
	process(all)
	variable temp_reg: std_logic_vector(127 downto 0);
	variable over_under_flow: signed(64 downto 0);
	variable max_val_64: signed (63 downto 0) := signed(b"0111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111");
	variable min_val_64: signed (63 downto 0) := signed(b"1000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000");
	
	
	begin
		temp_reg(63 downto 0) := std_logic_vector(signed(rs2(63 downto 32)) * signed(rs3(63 downto 32)));		 --first 32-bit field
		
		over_under_flow := resize(signed(rs1(63 downto 0)), 65) + resize(signed(temp_reg(63 downto 0)),65);
		if(over_under_flow >= max_val_64) then
			rd(63 downto 0) <= std_logic_vector(max_val_64);
		elsif(over_under_flow <= min_val_64) then
			rd(63 downto 0) <= std_logic_vector(min_val_64);
		else
			rd(63 downto 0) <= std_logic_vector(signed(rs1(63 downto 0)) + signed(temp_reg(63 downto 0)));
		end if;
----------------------------------------------------------------------------------------------------------------------------------------------------------						
		temp_reg(127 downto 64) := std_logic_vector(signed(rs2(127 downto 96)) * signed(rs3(127 downto 96)));	  --second 32-bit field
		
		over_under_flow := resize(signed(rs1(127 downto 64)), 65) + resize(signed(temp_reg(127 downto 64)),65);
		if(over_under_flow >= max_val_64) then
			rd(127 downto 64) <= std_logic_vector(max_val_64);
		elsif(over_under_flow <= min_val_64) then
			rd(127 downto 64) <= std_logic_vector(min_val_64);
		else
			rd(127 downto 64) <= std_logic_vector(signed(rs1(127 downto 64)) + signed(temp_reg(127 downto 64)));
		end if;	
	end process;
end behavioral;
