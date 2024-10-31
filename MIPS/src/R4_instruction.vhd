-------------------------------------------------------------------------------
--
-- Title       : SIMD_ALU
-- Design      : SIMD ALU
-- Author      : aritro.sarkar9000@gmail.com
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:/My_Designs/ESE345_Project_part_1/SIMD ALU/src/SIMD_ALU.vhd
-- Generated   : Tue Oct 29 17:15:44 2024
-- From        : Interface description file
-- By          : ItfToHdl ver. 1.0
--
-------------------------------------------------------------------------------
--
-- Description : An SIMD Multimedia ALU that can perform various operations
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;	 
use work.all;


entity R4_instruction is  
	port(										   
	  rs1 : in STD_LOGIC_VECTOR(127 downto 0);
	  rs2 : in STD_LOGIC_VECTOR(127 downto 0);
	  rs3 : in STD_LOGIC_VECTOR(127 downto 0);
		opcode : in STD_LOGIC_VECTOR(2 downto 0);
	  rd_out : out STD_LOGIC_VECTOR(127 downto 0)
	);
end R4_instruction;

architecture R4_instruction of R4_instruction is
	signal result_000 : STD_LOGIC_VECTOR(127 downto 0);
	signal result_001 : STD_LOGIC_VECTOR(127 downto 0);
	signal result_010 : STD_LOGIC_VECTOR(127 downto 0);
	signal result_011 : STD_LOGIC_VECTOR(127 downto 0);
	signal result_100 : STD_LOGIC_VECTOR(127 downto 0);
	signal result_101 : STD_LOGIC_VECTOR(127 downto 0);
	signal result_110 : STD_LOGIC_VECTOR(127 downto 0);
	signal result_111 : STD_LOGIC_VECTOR(127 downto 0);
begin
	SIMALS_inst : entity work.Signed_Integer_Multiply_ADD_LOW_w_Saturation
		port map(
			rs1 => rs1,
			rs2 => rs2,
			rs3 => rs3,
			rd => result_000
		);

	SIMAHS_inst : entity work.Signed_Integer_Multiply_Add_High_w_Saturation
		port map(
			rs1 => rs1,
			rs2 => rs2,
			rs3 => rs3,
			rd => result_001
		);

	SIMSLS_inst : entity work.Signed_Integer_Multiply_Subtract_Low_w_Saturation
		port map(
			rs1 => rs1,
			rs2 => rs2,
			rs3 => rs3,
			rd => result_010
		);

	SIMSHS_inst : entity work.Signed_Integer_Multiply_Subtract_High_w_Saturation
		port map(
			rs1 => rs1,
			rs2 => rs2,
			rs3 => rs3,
			rd => result_011
		);

	SLIMALS_inst : entity work.Signed_Long_Integer_Multiply_Add_Low_w_Saturation
		port map(
			rs1 => rs1,
			rs2 => rs2,
			rs3 => rs3,
			rd => result_100
		);

	SLIMAHS_inst : entity work.Signed_Long_Integer_Multiply_Add_High_w_Saturation
		port map(
			rs1 => rs1,
			rs2 => rs2,
			rs3 => rs3,
			rd => result_101
		);

	SLIMSLS_inst : entity work.Signed_Long_Integer_Multiply_Subtract_Low_w_Saturation
		port map(
			rs1 => rs1,
			rs2 => rs2,
			rs3 => rs3,
			rd => result_110
		);

	SLIMSHS_inst : entity work.Signed_Long_Integer_Multiply_Subtract_High_w_Saturation
		port map(
			rs1 => rs1,
			rs2 => rs2,
			rs3 => rs3,
			rd => result_111
		);

	with opcode select
		rd_out <=
						result_000 when "000",
						result_001 when "001",
						result_010 when "010",
						result_011 when "011",
						result_100 when "100",
						result_101 when "101",
						result_110 when "110",
						result_111 when "111",
						(others => '0') when others;

end R4_instruction;
