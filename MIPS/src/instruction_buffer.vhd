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
		rst : in std_logic;
		load_en : in std_logic;
		instruction_in : in std_logic_vector(24 downto 0);
		instruction_out : out std_logic_vector(24 downto 0);
		no_more_instruction : out std_logic;
		PC_out_v : out std_logic_vector(5 downto 0)
	);
end instruction_buffer;

architecture behavioral of instruction_buffer is
constant line_length : integer := 64;
type instruction_buffer is array(0 to line_length-1) of std_logic_vector(24 downto 0);
signal instr_buffer : instruction_buffer;
signal PC_current : std_logic_vector(5 downto 0);
begin

	PC_inst : entity work.Program_Counter
		port map(
			clk => clk,
			rst => rst,
			PC_out => PC_current,
			PC_out_2 => PC_out_v
		);

	-- loading instructions into instruction buffer
	process(clk, rst)
	begin
		if rst = '1' then
			instr_buffer <= (others => (others => '0'));
			no_more_instruction <= '0';
		elsif rising_edge(clk) then
			if load_en = '1' then
				instr_buffer(to_integer(unsigned(PC_current))) <= instruction_in;
			else
				instruction_out <= instr_buffer(to_integer(unsigned(PC_current)));	
				if to_integer(unsigned(PC_current)) = line_length-1 then
					no_more_instruction <= '1';
				else
					no_more_instruction <= '0';
				end if;
			end if;
		end if;
	end process;
end behavioral;
