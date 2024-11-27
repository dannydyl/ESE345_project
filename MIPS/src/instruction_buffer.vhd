-------------------------------------------------------------------------------
--
-- Title       : instruction_buffer
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : //Mac/Home/Documents/SBU_2024_Fall/ESE345/ese345_project/ese345_project/MIPS/src/instruction_buffer.vhd
-- Generated   : Tue Nov 26 22:02:31 2024
-- From        : Interface description file
-- By          : ItfToHdl ver. 1.0
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_buffer is
	port(
		clk : in std_logic;
		load_en : in std_logic;
		PC_in : in std_logic_vector(5 downto 0);
		instruction_in : in std_logic_vector(24 downto 0);
		instruction_out : out std_logic_vector(24 downto 0)
	);
end instruction_buffer;

architecture behavioral of instruction_buffer is
constant line_length : integer := 64;
type instruction_buffer is array(0 to line_length-1) of std_logic_vector(24 downto 0);
signal instr_buffer : instruction_buffer;
begin

	-- loading instructions into instruction buffer
	process(clk)
	begin
		if rising_edge(clk) then
			if load_en = '1' then
				instr_buffer(to_integer(unsigned(PC_in))) <= instruction_in;
			end if;
		end if;
	end process;

	-- instruction being fetched from instruction buffer
	process(clk)
	begin
		if rising_edge(clk) then
			instruction_out <= instr_buffer(to_integer(unsigned(PC_in)));
		end if;
	end process;

end instruction_buffer;
