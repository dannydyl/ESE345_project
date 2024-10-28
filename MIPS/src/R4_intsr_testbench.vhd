-------------------------------------------------------------------------------
--
-- Title       : R4_intsr_testbench
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : //Mac/Home/Documents/SBU_2024_Fall/ESE345/ese345_project/ese345_project/MIPS/src/R4_intsr_testbench.vhd
-- Generated   : Thu Oct 24 15:21:57 2024
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

entity R4_intsr_testbench is
end R4_intsr_testbench;

architecture R4_intsr_testbench of R4_intsr_testbench is
signal instr : std_logic_vector(2 downto 0);
signal a : std_logic_vector(127 downto 0);
signal b : std_logic_vector(127 downto 0);
signal c : std_logic_vector(127 downto 0);
signal result : std_logic_vector(127 downto 0);	
begin
	r4_instr : work.r4_instr
		port map(
			instr => instr,
			a => a,
			b => b,
			c => c,
			result => result
		);

	process
	begin
		-- Test case instr = 000 -> Signed Integer Multiply-Add Low with Saturation
		instr <= "000";
		a <= x"01230002" & x"89AB0002" & x"01230002" & x"89AB0002"; -- each field is 32 bits
		b <= x"01230003" & x"89AB0003" & x"01230003" & x"89AB0003";
		c <= x"01230004" & x"89AB0004" & x"01230004" & x"89AB0004";
		wait for 1 ns;
		assert result = 2 * 3 + 4
		report "Test Case Failed, Expected 10 for each 32bit field (0x0000000A), got " & integer'image(signed(result))
		severity error;
		wait for 1 ns;
	
	end process;


end R4_intsr_testbench;
