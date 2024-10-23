-------------------------------------------------------------------------------
--
-- Title       : R3_instruction
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : //Mac/Home/Documents/SBU_2024_Fall/ESE345/ese345_project/ese345_project/MIPS/src/R3_instruction.vhd
-- Generated   : Mon Oct 21 16:29:10 2024
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
use work.op_package.all;

entity R3_instruction is	 
	port(									   
	opcode : in std_logic_vector(7 downto 0);
	a : in std_logic_vector(127 downto 0); -- from rs2
	b : in std_logic_vector(127 downto 0); -- from rs1
	result : out std_logic_vector(127 downto 0)
	
	);
end R3_instruction;


architecture R3_instruction of R3_instruction is
signal current_op : std_logic_vector(3 downto 0);
signal shamt : integer := 0;
begin
	current_op <= opcode(3 downto 0);
	--shamt <= to_integer()

	-- need module for CLZ, saturated arithmetic, count 1s
	CLZ_module : entity work.CLZ
		port map(


	-- case statement for decoding opcode
	process(opcode, a, b)
	begin
		case current_op is 
			--when OP_NOP =>
			-- no operation
			when OP_SLHI => 
				--result <= -- question about the shift amount
			when OP_AU => 
				result(127 downto 96) <= std_logic_vector(to_unsigned(a(127 downto 96)) + to_unsigned(b(127 downto 96)));
				result(95 downto 64) <= std_logic_vector(to_unsigned(a(95 downto 64)) + to_unsigned(b(95 downto 64)));
				result(63 downto 32) <= std_logic_vector(to_unsigned(a(63 downto 32)) + to_unsigned(b(63 downto 32)));
				result(31 downto 0) <= std_logic_vector(to_unsigned(a(31 downto 0)) + to_unsigned(b(31 downto 0)));
			when OP_CNTIH => 
				result <= --something
			when OP_AHS => 
				result <= --something
			when OP_AND => 
				result <= a AND b;
			when OP_BCW => 
				result(127 downto 96) <= b(31 downto 0);
				result(95 downto 64) <= b(31 downto 0);
				result(63 downto 32) <= b(31 downto 0);
				result(31 downto 0) <= b(31 downto 0);
			when OP_MAXWS => 
				result(128 downto 96) <= 
				result(95 downto 64)
				result(63 downto 32)
				result(31 downto 0)
				when OP_MINWS => 
				result <= --something
			when OP_MLHU => 
				result(128 downto 96) <= std_logic_vector(to_unsigned(a(111 downto 96)) * to_unsigned(b(111 downto 96)));
				result(95 downto 64) <= std_logic_vector(to_unsigned(a(79 downto 64)) * to_unsigned(b(79 downto 64)));
				result(63 downto 32) <= std_logic_vector(to_unsigned(a(47 downto 32)) * to_unsigned(b(47 downto 32)));
				result(31 downto 0) <= std_logic_vector(to_unsigned(a(15 downto 0)) * to_unsigned(b(15 downto 0)));
			when OP_MLHCU => 
				result(128 downto 96) <= 
				result(95 downto 64)
				result(63 downto 32)
				result(31 downto 0)
			when OP_OR => 
				result <= a OR b;
			when OP_CLZH => 
				result <= --something
			when OP_RLH => 
				result <= --something
			when OP_SFWU => 
				result(127 downto 96) <= std_logic_vector(to_unsigned(a(127 downto 96)) - to_unsigned(b(127 downto 96)));
				result(95 downto 64) <= std_logic_vector(to_unsigned(a(95 downto 64)) - to_unsigned(b(95 downto 64)));
				result(63 downto 32) <= std_logic_vector(to_unsigned(a(63 downto 32)) - to_unsigned(b(63 downto 32)));
				result(31 downto 0) <= std_logic_vector(to_unsigned(a(31 downto 0)) - to_unsigned(b(31 downto 0)));
			when OP_SFHS => 
				result <= --something
			when others =>
				result <= (others => '0');
		end case;
	end process;
	

end R3_instruction;
