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
		instruction : in std_logic_vector(24 downto 0);
		done_flag : out std_logic;

		-- for each register stage (v for verification)
		PC_v : out std_logic_vector(5 downto 0);

		IF_ID_instruction_v : out std_logic_vector(24 downto 0);

		ID_EX_instr_opcode_v : out std_logic_vector(9 downto 0);
		ID_EX_instr_imme_v : out std_logic_vector(15 downto 0);
		ID_EX_instr_rd_v : out std_logic_vector(4 downto 0);
		ID_EX_rs1_data_v : out std_logic_vector(127 downto 0);
		ID_EX_rs2_data_v : out std_logic_vector(127 downto 0);
		ID_EX_rs3_data_v : out std_logic_vector(127 downto 0);
		ID_EX_rs1_addr_v : out std_logic_vector(4 downto 0);
		ID_EX_rs2_addr_v : out std_logic_vector(4 downto 0);
		ID_EX_rs3_addr_v : out std_logic_vector(4 downto 0);
		ID_EX_write_en_v : out std_logic;
		ID_EX_load_flag_v : out std_logic;

		FW_rs1_select_v : out std_logic;
		FW_rs2_select_v : out std_logic;
		FW_rs3_select_v : out std_logic;

		ALU_result_v : out std_logic_vector(127 downto 0);

		EX_WB_rd_address_v : out std_logic_vector(4 downto 0);
		EX_WB_rd_data_v : out std_logic_vector(127 downto 0);
		EX_WB_write_en_v : out std_logic;

		WB_write_addr_v : out std_logic_vector(4 downto 0);
		WB_write_data_v : out std_logic_vector(127 downto 0)

	);
end Processor_top_level;


architecture Processor_top_level of Processor_top_level is
-- signal PC : std_logic_vector(5 downto 0);
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

signal rs1_muxed_data : std_logic_vector(127 downto 0);
signal rs2_muxed_data : std_logic_vector(127 downto 0);
signal rs3_muxed_data : std_logic_vector(127 downto 0);

signal rd_data_EX_WB	: std_logic_vector(127 downto 0);

signal write_en_out_EX_WB : std_logic;
signal write_en_out_ID_EX : std_logic;

-- signal reg_write_addr : std_logic_vector(31 downto 0);
-- signal reg_write_data : std_logic_vector(127 downto 0);

signal instr_rd : std_logic_vector(4 downto 0);

signal write_en_out_rf : std_logic;

signal ALU_result : std_logic_vector(127 downto 0);

signal instr_rd_EX_WB : std_logic_vector(4 downto 0);

signal rs1_select : std_logic;
signal rs2_select : std_logic;
signal rs3_select : std_logic;

signal load_rf : std_logic;
signal load_flag_ID_EX : std_logic;

signal rs1_rf : std_logic_vector(4 downto 0);
signal rs2_rf : std_logic_vector(4 downto 0);
signal rs3_rf : std_logic_vector(4 downto 0);

signal rs1_addr_ID_EX : std_logic_vector(4 downto 0);
signal rs2_addr_ID_EX : std_logic_vector(4 downto 0);
signal rs3_addr_ID_EX : std_logic_vector(4 downto 0);

signal rd_read_load : std_logic_vector(127 downto 0);

begin

	instr_buffer_inst : entity work.instruction_buffer
		port map(
			clk => clk,
			rst => rst,
			load_en => load_en,
			instruction_in => instruction,
			instruction_out => fetched_instruction,
			no_more_instruction => done_flag, -- when all instructions are executed, done_flag is set to 1
			PC_out_v => PC_v
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
			reg_write_en => write_en_out_EX_WB,
			reg_write_addr => instr_rd_EX_WB,
			reg_write_data => rd_data_EX_WB,
			instruction => IF_ID_instruction, -- input instruction [24:0]
			reg_read_addr1 => IF_ID_instruction(9 downto 5),
			reg_read_addr2 => IF_ID_instruction(14 downto 10),
			reg_read_addr3 => IF_ID_instruction(19 downto 15),
			reg_read_rd => IF_ID_instruction(4 downto 0),

			reg_read_data1 => rs1_data,
			reg_read_data2 => rs2_data,
			reg_read_data3 => rs3_data,
			reg_read_data_rd => rd_read_load,
			reg_rs1_addr_out => rs1_rf, -- rs1, rs2, rs3 address for forwarding unit
			reg_rs2_addr_out => rs2_rf,
			reg_rs3_addr_out => rs3_rf,
			instr_opcode => instr_opcode, -- extract opcode instruction[24:15]
			instr_imme => instr_imme, -- extract immediate instruction[20:5]
			instr_rd => instr_rd, -- extract rd instruction[4:0]
			write_en_out => write_en_out_rf,
			load_flag_out => load_rf
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
			rs1_addr_in => rs1_rf,
			rs2_addr_in => rs2_rf,
			rs3_addr_in => rs3_rf,
			write_en_in => write_en_out_rf,
			load_flag_in => load_rf,

			instr_opcode_out => instr_opcode_ID_EX,
			instr_imme_out => instr_imme_ID_EX,
			instr_rd_out => instr_rd_ID_EX,
			rs1_data_out => rs1_data_ID_EX,
			rs2_data_out => rs2_data_ID_EX,
			rs3_data_out => rs3_data_ID_EX,
			rs1_addr_out => rs1_addr_ID_EX,
			rs2_addr_out => rs2_addr_ID_EX,
			rs3_addr_out => rs3_addr_ID_EX,
			write_en_out => write_en_out_ID_EX,
			load_flag_out => load_flag_ID_EX
		);

	Forwarding_unit_inst : entity work.forwarding_unit
		port map(
			instr_type => instr_opcode_ID_EX(9 downto 8),
			instruction_WB => instr_rd_EX_WB,
			rd_addr_EX => instr_rd_ID_EX,
			rs1_addr_EX => rs1_addr_ID_EX,
			rs2_addr_EX => rs2_addr_ID_EX,
			rs3_addr_EX => rs3_addr_ID_EX,
			write_en_EX => write_en_out_ID_EX,
			load_flag_in => load_flag_ID_EX,
			rs1_select => rs1_select,
			rs2_select => rs2_select,
			rs3_select => rs3_select
		);

	Fowarding_mux_inst : entity work.forwarding_mux
		port map(
			rs1_reg => rs1_data_ID_EX,
			rs2_reg => rs2_data_ID_EX,
			rs3_reg => rs3_data_ID_EX,
			rd_EX_WB => rd_data_EX_WB,
			rs1_select => rs1_select,
			rs2_select => rs2_select,
			rs3_select => rs3_select,

			rs1 => rs1_muxed_data,
			rs2 => rs2_muxed_data,
			rs3 => rs3_muxed_data
		);

	ALU_inst : entity work.ALU_top_level
		port map(
			input_rs3 => rs3_muxed_data,
			input_rs2 => rs2_muxed_data,
			input_rs1 => rs1_muxed_data,
			input_rd => rd_read_load,
			instr => instr_opcode_ID_EX,
			imme => instr_imme_ID_EX,
			output_result => ALU_result
		);

	EX_WB_inst : entity work.EX_WB_Reg
		port map(
			clk => clk,
			rst => rst,
			rd_address_in => instr_rd_ID_EX,
			rd_in => ALU_result,
			write_en_in => write_en_out_ID_EX,

			rd_address_out => instr_rd_EX_WB,
			rd_out => rd_data_EX_WB,
			write_en_out => write_en_out_EX_WB
		);

		IF_ID_instruction_v <= fetched_instruction;

		ID_EX_instr_opcode_v <= instr_opcode;
		ID_EX_instr_imme_v <= instr_imme;
		ID_EX_instr_rd_v <= instr_rd;
		ID_EX_rs1_data_v <= rs1_data;
		ID_EX_rs2_data_v <= rs2_data;
		ID_EX_rs3_data_v <= rs3_data;
		ID_EX_rs1_addr_v <= rs1_rf;
		ID_EX_rs2_addr_v <= rs2_rf;
		ID_EX_rs3_addr_v <= rs3_rf;
		ID_EX_write_en_v <= write_en_out_rf;
		ID_EX_load_flag_v <= load_rf;

		FW_rs1_select_v <= rs1_select;
		FW_rs2_select_v <= rs2_select;
		FW_rs3_select_v <= rs3_select;

		ALU_result_v <= ALU_result;

		EX_WB_rd_address_v <= instr_rd_ID_EX;
		EX_WB_rd_data_v <= ALU_result;
		EX_WB_write_en_v <= write_en_out_ID_EX;

		WB_write_addr_v <= instr_rd_EX_WB;
		WB_write_data_v <= rd_data_EX_WB;

end Processor_top_level;
