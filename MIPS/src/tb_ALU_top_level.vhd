-------------------------------------------------------------------------------
--
-- Title       : tb_ALU_top_level
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : //Mac/Home/Documents/SBU_2024_Fall/ESE345/ese345_project/ese345_project/MIPS/src/tb_ALU_top_level.vhd
-- Generated   : Tue Oct 29 12:41:25 2024
-- From        : Interface description file
-- By          : ItfToHdl ver. 1.0
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;			 
use work.all;

entity tb_ALU_top_level is
end tb_ALU_top_level;


architecture tb_ALU_top_level of tb_ALU_top_level is
	signal input_a : std_logic_vector(127 downto 0);
	signal input_b : std_logic_vector(127 downto 0);
	signal input_c : std_logic_vector(127 downto 0);
	signal instr : std_logic_vector(9 downto 0);
	signal imme  : std_logic_vector(15 downto 0);
	signal output_result : std_logic_vector(127 downto 0);
begin
	ALU_top_level_inst : entity work.ALU_top_level
		port map(
			input_a => input_a,
			input_b => input_b,
			input_c => input_c,
			instr => instr,
			imme => imme,
			output_result => output_result
		);

		Li_tb : process
		begin								  
			report "Testbench start";
			report "initializing inputs";
			input_a <= x"00000000_00000000_00000000_00000000";
			input_b <= x"00000000_00000000_00000000_00000000";	
			input_c <= x"00000000_00000000_00000000_00000000";	
			instr <= "0000000000";
			imme <= "0000000000000000";
			wait for 1 ns;			   
			report "Initialize done";
			report "Li instruction testbench starting...";
			--Test case 1
			imme <= "0000000000000001";
			instr <= "0000000000"; -- index 0
			input_a <= x"00000000_00000000_00000000_00000000";
			wait for 1 ns;

			assert output_result(127 downto 0) = x"00000000_00000000_00000000_00000001" 
			report "[Li] Test Case 1 Failed, input imme = 16b'0000000000000001, index = 4b'0000, Expected 0x0000000000000001, got "
			& to_hstring(output_result) 
			severity error;

			-- Test case 2
			imme <= "0000000000000001";
			instr <= "0001000000"; -- index 1
			wait for 1 ns;

			assert output_result(127 downto 0) = x"00000000_00000000_00000000_00010000"
			report "[Li] Test Case 2 Failed, input imme = 16b'0000000000000001, index = 4b'0001, Expected 0x0000000000000100, got "
			& to_hstring(output_result)
			severity error;
			
			-- Test case 3
			imme <= "0000000000000001";
			instr <= "0010000000"; -- index 2
			wait for 1 ns;

			assert output_result(127 downto 0) = x"00000000_00000000_00000001_00000000"
			report "[Li] Test Case 3 Failed, input imme = 16b'0000000000000001, index = 4b'0010, Expected 0x0000000000010000, got "
			& to_hstring(output_result)
			severity error;

			report "R4 instruction testbench starting...";

			report "R3 instruction testbench starting...";

			report "[R3] testing nop";

			-- will use this as input for all R3 instructions except for constant instructions & saturated arithmetic to show that saturation logic is working
			input_a <= x"01230001" & x"03230002" & x"01230003" & x"03230004"; -- [rs2] each field is 32 bits
			input_b <= x"01230004" & x"02320003" & x"01230002" & x"02320001"; -- [rs1]

			instr <= "1100000000"; -- nop
			wait for 1 ns;
			
			report "[R3] testing SLHI";
			instr <= "1100000001"; -- SLHI shft left on rs1 which is input_b
			imme <= "0000000001000000"; -- R2 field for shamt. shamt = 2 which is * 4
			wait for 1 ns;
			assert output_result = x"048c0004" & x"0c8c0008" & x"048c000c" & x"0c8c0010"
			report "[R3] SLHI test failed, expected 0x048C0004 0x08C8000C 0x048C0008 0x08C80004, got " & to_hstring(output_result)
			severity error;

			report "[R3] testing AU";
			instr <= "1100000010"; -- AU add word unsigned
			wait for 1 ns;
			assert output_result = x"02460005" & x"05550005" & x"02460005" & x"05550005"
			report "[R3] AU test failed, expected 0x02460005 0x05550005 0x02460005 0x05550005, got " & to_hstring(output_result)
			severity error;
			
			report "[R3] testing CNT1H"; -- count 1s in halfword
			instr <= "1100000011";
			wait for 1 ns;
			assert output_result = x"00040001_00050001_00040002_00050001"
			report "[R3] CNT1H test failed, expected 00040001_00050001_00040002_00050001, got " & to_hstring(output_result)
			severity error;

			report "[R3] testing AHS"; -- add halfword saturated
			instr <= "1100000100";
			input_a <= x"00007FFF" & x"00008000" & x"FFFF8000" & x"00001000";
			input_b <= x"00002000" & x"00009000" & x"FFFF9000" & x"00007000";
			wait for 1 ns;
			assert output_result = x"00007fff" & x"00008000" & x"fffe8000" & x"00007fff"
			report "[R3] AHS test failed, expected 0x00007fff 0x00008000 0xfffe8000 0x00007fff, got " & to_hstring(output_result)
			severity error;

			report "[R3] testing AND"; -- bitwise logical and
			instr <= "1100000101";
			input_a <= x"01230001" & x"03230002" & x"01230003" & x"03230004";
			input_b <= x"01230004" & x"02320003" & x"01230002" & x"02320001";
			wait for 1 ns;
			assert output_result <= (input_a and input_b)
			report "[R3] AND test failed, expected 0x01230000 0x02320000 0x01230000 0x02320000, got " & to_hstring(output_result)
			severity error;

			report "[R3] testing BCW"; -- broadcast word
			instr <= "1100000110";
			wait for 1 ns;
			assert output_result <= x"02320001" & x"02320001" & x"02320001" & x"02320001"
			report "[R3] BCW test failed, expected 0x02320001 0x02320001 0x02320001 0x02320001, got " & to_hstring(output_result)
			severity error;

			report "[R3] testing MAXWS"; -- max signed word
			instr <= "1100000111";
			wait for 1 ns;
			assert output_result <= x"01230004" & x"03230002" & x"01230003" & x"03230004"
			report "[R3] MAXWS test failed, expected 0x01230004 0x03230002 0x01230003 0x03230004, got " & to_hstring(output_result)
			severity error;

			report "[R3] testing MINWS"; -- min signed word
			instr <= "1100001000";
			wait for 1 ns;
			assert output_result <= x"01230001" & x"02320003" & x"01230002" & x"02320001"
			report "[R3] MINWS test failed, expected 0x01230001 0x02320003 0x01230002 0x02320001, got " & to_hstring(output_result)
			severity error;

			report "[R3] testing MLHU"; -- multiply low unsigned
			instr <= "1100001001";
			wait for 1 ns;
			assert output_result <= x"00000004" & x"00000006" & x"00000006" & x"00000004"
			report "[R3] MLHU test failed, expected 0x00000004 0x00000006 0x00000006 0x00000004, got " & to_hstring(output_result)
			severity error;

			report "[R3] testing MLHCU"; -- multiply low by constant unsigned
			instr <= "1100001010";
			imme <= "0000000001000000"; -- multiply constant 2
			wait for 1 ns;
			assert output_result <= x"00000008" & x"00000006" & x"00000004" & x"00000002"
			report "[R3] MLHCU test failed, expected 0x00000008 0x00000006 0x00000004 0x00000002, got " & to_hstring(output_result)
			severity error;

			report "[R3] testing OR"; -- bitwise logical or
			instr <= "1100001011";
			wait for 1 ns;
			assert output_result <= (input_a or input_b)
			report "[R3] OR test failed, expected 0x01230005 0x03330003 0x01230003 0x03330005, got " & to_hstring(output_result)
			severity error;

			report "[R3] testing CLZH"; -- count leading zeroes in halfwords from rs1
			instr <= "1100001100";
			wait for 1 ns;
			assert output_result <= x"0007000F" & x"0006000E" & x"0007000E" & x"0006000D"			 
			report "[R3] CLZH test failed, expected 0x0007000F 0x0006000E 0x0007000E 0x0006000D, got " & to_hstring(output_result)
			severity error;

			report "[R3] testing RLH"; -- rotate left bits in halfwords
			instr <= "1100001101";
			wait for 1 ns;
			assert output_result <= x"011C0008" & x"0194000C" & x"011C0010" & x"01940010"
			report "[R3] RLH test failed, expected 0x011C0008 0x0194000C 0x011C0010 0x01940010, got " & to_hstring(output_result)
			severity error;

			report "[R3] testing SFWU"; -- subtract from word unsigned
			instr <= "1100001110";
			input_a <= x"01230006" & x"03230008" & x"01230009" & x"03230004"; -- [rs2] each field is 32 bits
			input_b <= x"01230004" & x"02320003" & x"01230002" & x"02320001"; -- [rs1]
			wait for 1 ns;
			assert output_result <= x"00000002" & x"00F10005" & x"00000007" & x"00F10003"
			report "[R3] SFWU test failed, expected 0x00000002 0x00F10005 0x00000007 0x00F10003, got " & to_hstring(output_result)
			severity error;

			report "[R3] testing SFHS"; -- subtract from halfword saturated
			instr <= "1100001111";
			input_a <= x"0123a100" & x"03230005" & x"01230003" & x"03230004"; -- [rs2] each field is 32 bits
			input_b <= x"0123FFFF" & x"02320003" & x"01230002" & x"02320001"; -- [rs1]
			wait for 1 ns;
			assert output_result <= x"00008000" & x"00F10002" & x"00000001" & x"00F10003"
			report "[R3] SFHS test failed, expected 0x00008000 0x00F10002 0x00000001 0x00F10003, got " & to_hstring(output_result)
			severity error;

			report "Testbench finished";
			std.env.stop;
		end process;


end tb_ALU_top_level;
