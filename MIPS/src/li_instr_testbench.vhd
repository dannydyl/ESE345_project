-------------------------------------------------------------------------------
--
-- Title       : li_instr_testbench
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : //Mac/Home/Documents/SBU_2024_Fall/ESE345/ese345_project/ese345_project/MIPS/src/li_instr_testbench.vhd
-- Generated   : Thu Oct 24 14:58:08 2024
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

entity li_instr_testbench is
end li_instr_testbench;


architecture li_instr_testbench of li_instr_testbench is
	component li_instr
		port(
			imme : in std_logic_vector(15 downto 0);
			index : in std_logic_vector(3 downto 0);
			output_result : out std_logic_vector(127 downto 0)
		);
	end component;

	signal imme : std_logic_vector(15 downto 0);
	signal index : std_logic_vector(3 downto 0);
	signal output_result : std_logic_vector(127 downto 0);


begin

	li_instr_inst : work.li_instr
		port map(
			imme => imme,
			index => index,
			output_result => output_result
		);

	process
	begin
		--Test case 1
		imme <= "0000000000000001";
		index <= "0000";
		wait for 1 ns;

		assert output_result(127 downto 0) = x"0000000000000001" 
		report "Test Case 1 Failed, input imme = 16b'0000000000000001, index = 4b'0000, Expected 0x0000000000000001, got "
		& to_hstring(output_result) 
		severity error;

		-- Test case 2
		imme <= "0000000000000001";
		index <= "0001";
		wait for 1 ns;

		assert output_result(127 downto 0) = x"0000000000000100"
		report "Test Case 2 Failed, input imme = 16b'0000000000000001, index = 4b'0001, Expected 0x0000000000000100, got "
		& to_hstring(output_result)
		severity error;
		
		-- Test case 3
		imme <= "0000000000000001";
		index <= "0010";
		wait for 1 ns;

		assert output_result(127 downto 0) = x"0000000000010000"
		report "Test Case 3 Failed, input imme = 16b'0000000000000001, index = 4b'0010, Expected 0x0000000000010000, got "
		& to_hstring(output_result)
		severity error;

	end process;

end li_instr_testbench;
