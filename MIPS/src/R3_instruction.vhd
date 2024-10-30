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
-----------------------------------------


--------------------------------------
--
-- Description : Compiled with VHDL2009 
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
signal SLHI_result : std_logic_vector(127 downto 0);
signal AU_result : std_logic_vector(127 downto 0);
signal shamt : integer := 0;
signal CLZ_result : std_logic_vector(127 downto 0);
signal AHS_result : std_logic_vector(127 downto 0);
signal CNT1H_result : std_logic_vector(127 downto 0);
signal SFHS_result : std_logic_vector(127 downto 0);
signal MAXWS_result : std_logic_vector(127 downto 0);
signal MINWS_result : std_logic_vector(127 downto 0);	 
signal BCW_result : std_logic_vector(127 downto 0);
signal MLHU_result : std_logic_vector(127 downto 0);
signal MLHCU_result : std_logic_vector(127 downto 0);
signal RLH_result : std_logic_vector(127 downto 0);
signal SFWU_result : std_logic_vector(127 downto 0);
begin
	-- prerequisite for operations
	current_op <= opcode(3 downto 0);
	shamt <= to_integer(unsigned(imme(3 downto 0)));
	SLHI_result <= std_logic_vector(shift_left(unsigned(a(127 downto 112)), shamt)) &
									std_logic_vector(shift_left(unsigned(a(111 downto 96)), shamt)) &
									std_logic_vector(shift_left(unsigned(a(95 downto 80)), shamt)) &
									std_logic_vector(shift_left(unsigned(a(79 downto 64)), shamt)) &
									std_logic_vector(shift_left(unsigned(a(63 downto 48)), shamt)) &
									std_logic_vector(shift_left(unsigned(a(47 downto 32)), shamt)) &
									std_logic_vector(shift_left(unsigned(a(31 downto 16)), shamt)) &
									std_logic_vector(shift_left(unsigned(a(15 downto 0)), shamt));

	AU_result <= std_logic_vector(unsigned(a(127 downto 96)) + unsigned(b(127 downto 96))) &
								std_logic_vector(unsigned(a(95 downto 64)) + unsigned(b(95 downto 64))) &
								std_logic_vector(unsigned(a(63 downto 32)) + unsigned(b(63 downto 32))) &
								std_logic_vector(unsigned(a(31 downto 0)) + unsigned(b(31 downto 0)));

	BCW_result <= b(31 downto 0) & b(31 downto 0) & b(31 downto 0) & b(31 downto 0);

	MLHU_result <= std_logic_vector(unsigned(a(111 downto 96)) * unsigned(b(111 downto 96))) &
									std_logic_vector(unsigned(a(79 downto 64)) * unsigned(b(79 downto 64))) &
									std_logic_vector(unsigned(a(47 downto 32)) * unsigned(b(47 downto 32))) &
									std_logic_vector(unsigned(a(15 downto 0)) * unsigned(b(15 downto 0)));

	SFWU_result <= std_logic_vector(unsigned(a(127 downto 96)) - unsigned(b(127 downto 96))) &
									std_logic_vector(unsigned(a(95 downto 64)) - unsigned(b(95 downto 64))) &
									std_logic_vector(unsigned(a(63 downto 32)) - unsigned(b(63 downto 32))) &
									std_logic_vector(unsigned(a(31 downto 0)) - unsigned(b(31 downto 0)));

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
			input_a => a,
			input_b => b,
			output_result => SFHS_result
		);

	MAXWS_module: entity work.MAXWS
		port map(
			input_a => a,
			input_b => b,
			output_result => MAXWS_result
		);

	MINWS_module: entity work.MINWS
		port map(
			input_a => a,
			input_b => b,
			output_result => MINWS_result
		);

	MLHCU_module: entity work.MLHCU
		port map(
			input_a => a,
			input_const => imme,
			output_result => MLHCU_result
		);

	RLH_module: entity work.RLH
		port map(
			input_a => a,
			input_b => b,
			output_result => RLH_result
		);


		
	with current_op select
	result <= 
						SLHI_result when OP_SLHI,

						AU_result when OP_AU,

						CNT1H_result when OP_CNTIH,

						AHS_result when OP_AHS,

						a AND b when OP_AND,

						BCW_result when OP_BCW,

						MAXWS_result when OP_MAXWS,

						MINWS_result when OP_MINWS,

						MLHU_result when OP_MLHU,

						MLHCU_result when OP_MLHCU,

						a OR b when OP_OR,

						CLZ_result when OP_CLZH,

						RLH_result when OP_RLH,

						SFWU_result when OP_SFWU,

						SFHS_result when OP_SFHS,

						(others => '0') when others;	
		
	-- case statement for decoding opcode
	-- process(opcode, a, b)
	-- begin
	-- 	case current_op is 
	-- 		when OP_NOP =>
	-- 			null;
	-- 		when OP_SLHI => 
	-- 			result(127 downto 112) <= std_logic_vector(shift_left(unsigned(a(127 downto 112)), shamt));
	-- 			result(111 downto 96) <= std_logic_vector(shift_left(unsigned(a(111 downto 96)), shamt));
	-- 			result(95 downto 80) <= std_logic_vector(shift_left(unsigned(a(95 downto 80)), shamt));
	-- 			result(79 downto 64) <= std_logic_vector(shift_left(unsigned(a(79 downto 64)), shamt));
	-- 			result(63 downto 48) <= std_logic_vector(shift_left(unsigned(a(63 downto 48)), shamt));
	-- 			result(47 downto 32) <= std_logic_vector(shift_left(unsigned(a(47 downto 32)), shamt));
	-- 			result(31 downto 16) <= std_logic_vector(shift_left(unsigned(a(31 downto 16)), shamt));
	-- 			result(15 downto 0) <= std_logic_vector(shift_left(unsigned(a(15 downto 0)), shamt));
	-- 		when OP_AU => 
	-- 			result(127 downto 96) <= std_logic_vector(unsigned(a(127 downto 96)) + unsigned(b(127 downto 96)));
	-- 			result(95 downto 64) <= std_logic_vector(unsigned(a(95 downto 64)) + unsigned(b(95 downto 64)));
	-- 			result(63 downto 32) <= std_logic_vector(unsigned(a(63 downto 32)) + unsigned(b(63 downto 32)));
	-- 			result(31 downto 0) <= std_logic_vector(unsigned(a(31 downto 0)) + unsigned(b(31 downto 0)));
	-- 		when OP_CNTIH => 
	-- 			result <= CNT1H_result;
	-- 		when OP_AHS => 
	-- 			result <= AHS_result;
	-- 		when OP_AND => 
	-- 			result <= a AND b;
	-- 		when OP_BCW => 
	-- 			result(127 downto 96) <= b(31 downto 0);
	-- 			result(95 downto 64) <= b(31 downto 0);
	-- 			result(63 downto 32) <= b(31 downto 0);
	-- 			result(31 downto 0) <= b(31 downto 0);
	-- 		when OP_MAXWS => 
	-- 			result <= MAXWS_result;
	-- 		when OP_MINWS => 
	-- 			result <= MINWS_result;
	-- 		when OP_MLHU => 
	-- 			result(127 downto 96) <= std_logic_vector(unsigned(a(111 downto 96)) * unsigned(b(111 downto 96)));
	-- 			result(95 downto 64) <= std_logic_vector(unsigned(a(79 downto 64)) * unsigned(b(79 downto 64)));
	-- 			result(63 downto 32) <= std_logic_vector(unsigned(a(47 downto 32)) * unsigned(b(47 downto 32)));
	-- 			result(31 downto 0) <= std_logic_vector(unsigned(a(15 downto 0)) * unsigned(b(15 downto 0)));
	-- 		when OP_MLHCU => 
	-- 			result <= MLHCU_result;
	-- 		when OP_OR => 
	-- 			result <= a OR b;
	-- 		when OP_CLZH => 
	-- 			result <= CLZ_result;
	-- 		when OP_RLH => 
	-- 			result <= RLH_result;
	-- 		when OP_SFWU => 
	-- 			result(127 downto 96) <= std_logic_vector(unsigned(a(127 downto 96)) - unsigned(b(127 downto 96)));
	-- 			result(95 downto 64) <= std_logic_vector(unsigned(a(95 downto 64)) - unsigned(b(95 downto 64)));
	-- 			result(63 downto 32) <= std_logic_vector(unsigned(a(63 downto 32)) - unsigned(b(63 downto 32)));
	-- 			result(31 downto 0) <= std_logic_vector(unsigned(a(31 downto 0)) - unsigned(b(31 downto 0)));
	-- 		when OP_SFHS => 
	-- 			result <= SFHS_result;
	-- 		when others =>
	-- 			null;
	-- 	end case;
	-- end process;
	

end R3_instruction;
