-------------------------------------------------------------------------------
--
-- Title       : Processor_top_level
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : //Mac/Home/Documents/SBU_2024_Fall/ESE345/ese345_project/ese345_project/MIPS/src/Processor_top_level.vhd
-- Generated   : Wed Nov 27 12:47:18 2024
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

entity Processor_top_level is
	port(
		clk : in std_logic;
		rst : in std_logic;
		load_en : in std_logic;
		instruction : in std_logic_vector(24 downto 0)

	);
end Processor_top_level;


architecture Processor_top_level of Processor_top_level is
signal PC : std_logic_vector(5 downto 0);
signal rs1_data : std_logic_vector(127 downto 0);
signal rs2_data : std_logic_vector(127 downto 0);
signal rs3_data : std_logic_vector(127 downto 0);
signal instr_opcode : std_logic_vector(9 downto 0);
signal instr_imme : std_logic_vector(15 downto 0);
signal fetched_instruction : std_logic_vector(24 downto 0);
signal IF_ID_instruction : std_logic_vector(24 downto 0);

signal rs1_data_ID_EX : std_logic_vector(127 downto 0);
signal rs2_data_ID_EX : std_logic_vector(127 downto 0);
signal rs3_data_ID_EX : std_logic_vector(127 downto 0);
signal instr_opcode_ID_EX : std_logic_vector(9 downto 0);
signal instr_imme_ID_EX : std_logic_vector(15 downto 0);
signal instr_rd_ID_EX : std_logic_vector(4 downto 0);
begin

	instr_buffer_inst : entity work.instruction_buffer
		port map(
			clk => clk,
			rst => rst,
			load_en => load_en,
			instruction_in => instruction,
			instruction_out => fetched_instruction
		);

	IF_ID_inst : entity work.IF_ID_Reg
		port map(
			clk => clk,
			rst => rst,
			instruction_in => fetched_instruction,
			instruction_out => IF_ID_instruction
		);

	RegFile_inst : entity work.Register_file
		port map(
			clk => clk,
			rst => rst,
			reg_write_en => reg_write_en,
			reg_write_addr => reg_write_addr,
			reg_write_data => reg_write_data,
			instruction => IF_ID_instruction, -- input instruction [24:0]
			reg_read_addr1 => IF_ID_instruction(9 downto 5),
			reg_read_addr2 => IF_ID_instruction(14 downto 10),
			reg_read_addr3 => IF_ID_instruction(19 downto 15),

			reg_read_data1 => rs1_data,
			reg_read_data2 => rs2_data,
			reg_read_data3 => rs3_data,
			instr_opcode => instr_opcode, -- extract opcode instruction[24:15]
			instr_imme => instr_imme, -- extract immediate instruction[20:5]
			instr_rd => instr_rd -- extract rd instruction[4:0]
		);

	ID_EX_inst : entity work.ID_EX_Reg
		port map(
			clk => clk,
			rst => rst,
			instr_opcode_in => instr_opcode,
			instr_imme_in => instr_imme,
			instr_rd_in => instr_rd,
			rs1_data_in => rs1_data,
			rs2_data_in => rs2_data,
			rs3_data_in => rs3_data,

			instr_opcode_out => instr_opcode_ID_EX,
			instr_imme_out => instr_imme_ID_EX,
			instr_rd_out => instr_rd_ID_EX,
			rs1_data_out => rs1_data_ID_EX,
			rs2_data_out => rs2_data_ID_EX,
			rs3_data_out => rs3_data_ID_EX
		);

	Fowarding_unit_inst : entity work.Fowarding_unit
		port map(

		);

	ALU_inst : entity work.ALU_top_level
		port map(
			input_rs3 => rs3_data_ID_EX,
			input_rs2 => rs2_data_ID_EX,
			input_rs1 => rs1_data_ID_EX,
			instr => instr_opcode_ID_EX,
			imme => instr_imme_ID_EX,
			output_result => ALU_result
		);

	EX_MEM_inst : entity work.EX_MEM_Reg
		port map(

		);

	
	


end Processor_top_level;
