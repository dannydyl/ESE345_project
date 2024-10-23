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
	opcode : in std_logic_vector(7 downto 0); -- [22:15] from R3 instruction
	imme : in std_logic_vector(4 downto 0); -- [14:10] rs2 field in R3 instruction
	a : in std_logic_vector(127 downto 0); -- from rs2
	b : in std_logic_vector(127 downto 0); -- from rs1
	result : out std_logic_vector(127 downto 0) -- goes to rd
	
	);
end R3_instruction;


architecture R3_instruction of R3_instruction is
signal current_op : std_logic_vector(3 downto 0);
signal shamt : integer := 0;
signal CLZ_result : std_logic_vector(127 downto 0);
signal AHS_result : std_logic_vector(127 downto 0);
signal CNT1H_result : std_logic_vector(127 downto 0);
signal SFHS_result : std_logic_vector(127 downto 0);
begin
	-- prerequisite for operations
	current_op <= opcode(3 downto 0);
	shamt <= unsigned(imme(3 downto 0));

	-- need module for CLZ, saturated arithmetic, count 1s
	CLZH_module : entity work.CLZ
		port map(
			input_hw => a,
			output_count => CLZ_result
		);

	AHS_module: entity work.AHS
		port map(
			a_input => a,
			b_input => b,
			result_output => AHS_result
		);

	CNT1H_module: entity work.CNT1H
		port map(
			input_hw => a,
			output_count => CNT1H_result
		);

	SFHS_module: entity work.SFHS
		port map(
			a_input => a,
			b_input => b,
			result_output => SFHS_result
		);

	-- case statement for decoding opcode
	process(opcode, a, b)
	begin
		case current_op is 
			--when OP_NOP =>
			-- no operation
			when OP_SLHI => 
				result(127 downto 112) <= std_logic_vector(shift_left(unsigned(a(127 downto 112)), shamt));
				result(111 downto 96) <= std_logic_vector(shift_left(unsigned(a(111 downto 96)), shamt));
				result(95 downto 80) <= std_logic_vector(shift_left(unsigned(a(95 downto 80)), shamt));
				result(79 downto 64) <= std_logic_vector(shift_left(unsigned(a(79 downto 64)), shamt));
				result(63 downto 48) <= std_logic_vector(shift_left(unsigned(a(63 downto 48)), shamt));
				result(47 downto 32) <= std_logic_vector(shift_left(unsigned(a(47 downto 32)), shamt));
				result(31 downto 16) <= std_logic_vector(shift_left(unsigned(a(31 downto 16)), shamt));
				result(15 downto 0) <= std_logic_vector(shift_left(unsigned(a(15 downto 0)), shamt));
			when OP_AU => 
				result(127 downto 96) <= std_logic_vector(unsigned(a(127 downto 96)) + unsigned(b(127 downto 96)));
				result(95 downto 64) <= std_logic_vector(unsigned(a(95 downto 64)) + unsigned(b(95 downto 64)));
				result(63 downto 32) <= std_logic_vector(unsigned(a(63 downto 32)) + unsigned(b(63 downto 32)));
				result(31 downto 0) <= std_logic_vector(unsigned(a(31 downto 0)) + unsigned(b(31 downto 0)));
			when OP_CNTIH => 
				result <= CNT1H_result;
			when OP_AHS => 
				result <= AHS_result;
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
				result(128 downto 96) <= std_logic_vector(unsigned(a(111 downto 96)) * unsigned(b(111 downto 96)));
				result(95 downto 64) <= std_logic_vector(unsigned(a(79 downto 64)) * unsigned(b(79 downto 64)));
				result(63 downto 32) <= std_logic_vector(unsigned(a(47 downto 32)) * unsigned(b(47 downto 32)));
				result(31 downto 0) <= std_logic_vector(unsigned(a(15 downto 0)) * unsigned(b(15 downto 0)));
			when OP_MLHCU => 
				result(128 downto 96) <= 
				result(95 downto 64)
				result(63 downto 32)
				result(31 downto 0)
			when OP_OR => 
				result <= a OR b;
			when OP_CLZH => 
				result <= CLZ_result;
			when OP_RLH => 
				result <= --something
			when OP_SFWU => 
				result(127 downto 96) <= std_logic_vector(unsigned(a(127 downto 96)) - unsigned(b(127 downto 96)));
				result(95 downto 64) <= std_logic_vector(unsigned(a(95 downto 64)) - unsigned(b(95 downto 64)));
				result(63 downto 32) <= std_logic_vector(unsigned(a(63 downto 32)) - unsigned(b(63 downto 32)));
				result(31 downto 0) <= std_logic_vector(unsigned(a(31 downto 0)) - unsigned(b(31 downto 0)));
			when OP_SFHS => 
				result <= SFHS_result;
			when others =>
				result <= (others => '0');
		end case;
	end process;
	

end R3_instruction;
