-------------------------------------------------------------------------------
--
-- Description : loads a 16-bit immediate value to a specified 16-bit field of the destination register.
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;

entity load_instruction is
	port(
		instruction : in STD_LOGIC_VECTOR(24 downto 0); 
		rd : inout STD_LOGIC_VECTOR(127 downto 0)
	);
end load_instruction;

architecture behavioral of load_instruction is	   
begin
	process(all)
	variable immediate: std_logic_vector(15 downto 0);
	variable load_index: std_logic_vector(2 downto 0);
	variable temp_reg: std_logic_vector(127 downto 0);	   
	begin
		immediate := instruction(20 downto 5);
		load_index := instruction(23 downto 21);
		temp_reg := rd;
		if (instruction(24) = '0') then
			--load immediate instruction
			case load_index is
				when "000" => temp_reg(15 downto 0) := immediate;
				when "001" => temp_reg(31 downto 16) := immediate;
				when "010" => temp_reg(47 downto 32) := immediate;
				when "011" => temp_reg(63 downto 48) := immediate;
				when "100" => temp_reg(79 downto 64) := immediate;
				when "101" => temp_reg(95 downto 80) := immediate;
				when "110" => temp_reg(111 downto 96) := immediate;
				when "111" => temp_reg(127 downto 112) := immediate;
				when others => null;
			end case;
			rd <= temp_reg;
		end if;
	end process;
end behavioral;
