-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\compile\Processor_top_level.vhd
-- Generated   : Thu Dec  5 16:54:25 2024
-- From        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\..\..\Processor_top_level.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity Processor_top_level is
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       load_en : in STD_LOGIC;
       instruction : in STD_LOGIC_VECTOR(24 downto 0);
       done_flag : out STD_LOGIC;
       PC_v : out STD_LOGIC_VECTOR(5 downto 0);
       IF_ID_instruction_v : out STD_LOGIC_VECTOR(24 downto 0);
       ID_EX_instr_opcode_v : out STD_LOGIC_VECTOR(9 downto 0);
       ID_EX_instr_imme_v : out STD_LOGIC_VECTOR(15 downto 0);
       ID_EX_instr_rd_v : out STD_LOGIC_VECTOR(4 downto 0);
       ID_EX_rs1_data_v : out STD_LOGIC_VECTOR(127 downto 0);
       ID_EX_rs2_data_v : out STD_LOGIC_VECTOR(127 downto 0);
       ID_EX_rs3_data_v : out STD_LOGIC_VECTOR(127 downto 0);
       ID_EX_rs1_addr_v : out STD_LOGIC_VECTOR(4 downto 0);
       ID_EX_rs2_addr_v : out STD_LOGIC_VECTOR(4 downto 0);
       ID_EX_rs3_addr_v : out STD_LOGIC_VECTOR(4 downto 0);
       ID_EX_write_en_v : out STD_LOGIC;
       ID_EX_load_flag_v : out STD_LOGIC;
       FW_rs1_select_v : out STD_LOGIC;
       FW_rs2_select_v : out STD_LOGIC;
       FW_rs3_select_v : out STD_LOGIC;
       ALU_result_v : out STD_LOGIC_VECTOR(127 downto 0);
       EX_WB_rd_address_v : out STD_LOGIC_VECTOR(4 downto 0);
       EX_WB_rd_data_v : out STD_LOGIC_VECTOR(127 downto 0);
       EX_WB_write_en_v : out STD_LOGIC;
       WB_write_addr_v : out STD_LOGIC_VECTOR(4 downto 0);
       WB_write_data_v : out STD_LOGIC_VECTOR(127 downto 0)
  );
end Processor_top_level;

architecture Processor_top_level of Processor_top_level is

---- Component declarations -----

component ALU_top_level
  port(
       input_rs3 : in STD_LOGIC_VECTOR(127 downto 0);
       input_rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       input_rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       instr : in STD_LOGIC_VECTOR(9 downto 0);
       imme : in STD_LOGIC_VECTOR(15 downto 0);
       output_result : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component EX_WB_Reg
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       rd_address_in : in STD_LOGIC_VECTOR(4 downto 0);
       rd_in : in STD_LOGIC_VECTOR(127 downto 0);
       write_en_in : in STD_LOGIC;
       rd_address_out : out STD_LOGIC_VECTOR(4 downto 0);
       rd_out : out STD_LOGIC_VECTOR(127 downto 0);
       write_en_out : out STD_LOGIC
  );
end component;
component forwarding_mux
  port(
       rs1_reg : in STD_LOGIC_VECTOR(127 downto 0);
       rs2_reg : in STD_LOGIC_VECTOR(127 downto 0);
       rs3_reg : in STD_LOGIC_VECTOR(127 downto 0);
       rd_EX_WB : in STD_LOGIC_VECTOR(127 downto 0);
       rs1_select : in STD_LOGIC;
       rs2_select : in STD_LOGIC;
       rs3_select : in STD_LOGIC;
       rs1 : out STD_LOGIC_VECTOR(127 downto 0);
       rs2 : out STD_LOGIC_VECTOR(127 downto 0);
       rs3 : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component forwarding_unit
  port(
       instr_type : in STD_LOGIC_VECTOR(1 downto 0);
       instruction_WB : in STD_LOGIC_VECTOR(4 downto 0);
       rd_addr_EX : in STD_LOGIC_VECTOR(4 downto 0);
       rs1_addr_EX : in STD_LOGIC_VECTOR(4 downto 0);
       rs2_addr_EX : in STD_LOGIC_VECTOR(4 downto 0);
       rs3_addr_EX : in STD_LOGIC_VECTOR(4 downto 0);
       write_en_EX : in STD_LOGIC;
       load_flag_in : in STD_LOGIC;
       rs1_select : out STD_LOGIC;
       rs2_select : out STD_LOGIC;
       rs3_select : out STD_LOGIC
  );
end component;
component ID_EX_Reg
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       instr_opcode_in : in STD_LOGIC_VECTOR(9 downto 0);
       instr_imme_in : in STD_LOGIC_VECTOR(15 downto 0);
       instr_rd_in : in STD_LOGIC_VECTOR(4 downto 0);
       rs1_data_in : in STD_LOGIC_VECTOR(127 downto 0);
       rs2_data_in : in STD_LOGIC_VECTOR(127 downto 0);
       rs3_data_in : in STD_LOGIC_VECTOR(127 downto 0);
       rs1_addr_in : in STD_LOGIC_VECTOR(4 downto 0);
       rs2_addr_in : in STD_LOGIC_VECTOR(4 downto 0);
       rs3_addr_in : in STD_LOGIC_VECTOR(4 downto 0);
       write_en_in : in STD_LOGIC;
       load_flag_in : in STD_LOGIC;
       instr_opcode_out : out STD_LOGIC_VECTOR(9 downto 0);
       instr_imme_out : out STD_LOGIC_VECTOR(15 downto 0);
       instr_rd_out : out STD_LOGIC_VECTOR(4 downto 0);
       rs1_data_out : out STD_LOGIC_VECTOR(127 downto 0);
       rs2_data_out : out STD_LOGIC_VECTOR(127 downto 0);
       rs3_data_out : out STD_LOGIC_VECTOR(127 downto 0);
       rs1_addr_out : out STD_LOGIC_VECTOR(4 downto 0);
       rs2_addr_out : out STD_LOGIC_VECTOR(4 downto 0);
       rs3_addr_out : out STD_LOGIC_VECTOR(4 downto 0);
       write_en_out : out STD_LOGIC;
       load_flag_out : out STD_LOGIC
  );
end component;
component IF_ID_Reg
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       instruction_in : in STD_LOGIC_VECTOR(24 downto 0);
       instruction_out : out STD_LOGIC_VECTOR(24 downto 0)
  );
end component;
component instruction_buffer
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       load_en : in STD_LOGIC;
       instruction_in : in STD_LOGIC_VECTOR(24 downto 0);
       instruction_out : out STD_LOGIC_VECTOR(24 downto 0);
       no_more_instruction : out STD_LOGIC;
       PC_out_v : out STD_LOGIC_VECTOR(5 downto 0)
  );
end component;
component Register_file
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       instruction : in STD_LOGIC_VECTOR(24 downto 0);
       reg_write_en : in STD_LOGIC;
       reg_write_addr : in STD_LOGIC_VECTOR(4 downto 0);
       reg_write_data : in STD_LOGIC_VECTOR(127 downto 0);
       reg_read_addr1 : in STD_LOGIC_VECTOR(4 downto 0);
       reg_read_addr2 : in STD_LOGIC_VECTOR(4 downto 0);
       reg_read_addr3 : in STD_LOGIC_VECTOR(4 downto 0);
       reg_read_data1 : out STD_LOGIC_VECTOR(127 downto 0);
       reg_read_data2 : out STD_LOGIC_VECTOR(127 downto 0);
       reg_read_data3 : out STD_LOGIC_VECTOR(127 downto 0);
       reg_rs1_addr_out : out STD_LOGIC_VECTOR(4 downto 0);
       reg_rs2_addr_out : out STD_LOGIC_VECTOR(4 downto 0);
       reg_rs3_addr_out : out STD_LOGIC_VECTOR(4 downto 0);
       instr_opcode : out STD_LOGIC_VECTOR(9 downto 0);
       instr_imme : out STD_LOGIC_VECTOR(15 downto 0);
       instr_rd : out STD_LOGIC_VECTOR(4 downto 0);
       write_en_out : out STD_LOGIC;
       load_flag_out : out STD_LOGIC
  );
end component;

---- Signal declarations used on the diagram ----

signal load_flag_ID_EX : STD_LOGIC;
signal load_rf : STD_LOGIC;
signal rs1_select : STD_LOGIC;
signal rs2_select : STD_LOGIC;
signal rs3_select : STD_LOGIC;
signal write_en_out_EX_WB : STD_LOGIC;
signal write_en_out_ID_EX : STD_LOGIC;
signal write_en_out_rf : STD_LOGIC;
signal ALU_result : STD_LOGIC_VECTOR(127 downto 0);
signal fetched_instruction : STD_LOGIC_VECTOR(24 downto 0);
signal IF_ID_instruction : STD_LOGIC_VECTOR(24 downto 0);
signal instr_imme : STD_LOGIC_VECTOR(15 downto 0);
signal instr_imme_ID_EX : STD_LOGIC_VECTOR(15 downto 0);
signal instr_opcode : STD_LOGIC_VECTOR(9 downto 0);
signal instr_opcode_ID_EX : STD_LOGIC_VECTOR(9 downto 0);
signal instr_rd : STD_LOGIC_VECTOR(4 downto 0);
signal instr_rd_EX_WB : STD_LOGIC_VECTOR(4 downto 0);
signal instr_rd_ID_EX : STD_LOGIC_VECTOR(4 downto 0);
signal rd_data_EX_WB : STD_LOGIC_VECTOR(127 downto 0);
signal rs1_addr_ID_EX : STD_LOGIC_VECTOR(4 downto 0);
signal rs1_data : STD_LOGIC_VECTOR(127 downto 0);
signal rs1_data_ID_EX : STD_LOGIC_VECTOR(127 downto 0);
signal rs1_muxed_data : STD_LOGIC_VECTOR(127 downto 0);
signal rs1_rf : STD_LOGIC_VECTOR(4 downto 0);
signal rs2_addr_ID_EX : STD_LOGIC_VECTOR(4 downto 0);
signal rs2_data : STD_LOGIC_VECTOR(127 downto 0);
signal rs2_data_ID_EX : STD_LOGIC_VECTOR(127 downto 0);
signal rs2_muxed_data : STD_LOGIC_VECTOR(127 downto 0);
signal rs2_rf : STD_LOGIC_VECTOR(4 downto 0);
signal rs3_addr_ID_EX : STD_LOGIC_VECTOR(4 downto 0);
signal rs3_data : STD_LOGIC_VECTOR(127 downto 0);
signal rs3_data_ID_EX : STD_LOGIC_VECTOR(127 downto 0);
signal rs3_muxed_data : STD_LOGIC_VECTOR(127 downto 0);
signal rs3_rf : STD_LOGIC_VECTOR(4 downto 0);

begin

----  Component instantiations  ----

ALU_inst : ALU_top_level
  port map(
       input_rs3 => rs3_muxed_data,
       input_rs2 => rs2_muxed_data,
       input_rs1 => rs1_muxed_data,
       instr => instr_opcode_ID_EX,
       imme => instr_imme_ID_EX,
       output_result => ALU_result
  );

EX_WB_inst : EX_WB_Reg
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

Forwarding_unit_inst : forwarding_unit
  port map(
       instr_type(1) => instr_opcode_ID_EX(9),
       instr_type(0) => instr_opcode_ID_EX(8),
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

Fowarding_mux_inst : forwarding_mux
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

ID_EX_inst : ID_EX_Reg
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

IF_ID_inst : IF_ID_Reg
  port map(
       clk => clk,
       rst => rst,
       instruction_in => fetched_instruction,
       instruction_out => IF_ID_instruction
  );

RegFile_inst : Register_file
  port map(
       clk => clk,
       rst => rst,
       instruction => IF_ID_instruction,
       reg_write_en => write_en_out_EX_WB,
       reg_write_addr => instr_rd_EX_WB,
       reg_write_data => rd_data_EX_WB,
       reg_read_addr1(4) => IF_ID_instruction(9),
       reg_read_addr1(3) => IF_ID_instruction(8),
       reg_read_addr1(2) => IF_ID_instruction(7),
       reg_read_addr1(1) => IF_ID_instruction(6),
       reg_read_addr1(0) => IF_ID_instruction(5),
       reg_read_addr2(4) => IF_ID_instruction(14),
       reg_read_addr2(3) => IF_ID_instruction(13),
       reg_read_addr2(2) => IF_ID_instruction(12),
       reg_read_addr2(1) => IF_ID_instruction(11),
       reg_read_addr2(0) => IF_ID_instruction(10),
       reg_read_addr3(4) => IF_ID_instruction(19),
       reg_read_addr3(3) => IF_ID_instruction(18),
       reg_read_addr3(2) => IF_ID_instruction(17),
       reg_read_addr3(1) => IF_ID_instruction(16),
       reg_read_addr3(0) => IF_ID_instruction(15),
       reg_read_data1 => rs1_data,
       reg_read_data2 => rs2_data,
       reg_read_data3 => rs3_data,
       reg_rs1_addr_out => rs1_rf,
       reg_rs2_addr_out => rs2_rf,
       reg_rs3_addr_out => rs3_rf,
       instr_opcode => instr_opcode,
       instr_imme => instr_imme,
       instr_rd => instr_rd,
       write_en_out => write_en_out_rf,
       load_flag_out => load_rf
  );

instr_buffer_inst : instruction_buffer
  port map(
       clk => clk,
       rst => rst,
       load_en => load_en,
       instruction_in => instruction,
       instruction_out => fetched_instruction,
       no_more_instruction => done_flag,
       PC_out_v => PC_v
  );


---- Terminal assignment ----

    -- Output\buffer terminals
	ALU_result_v <= ALU_result;
	EX_WB_rd_address_v <= instr_rd_ID_EX;
	EX_WB_rd_data_v <= ALU_result;
	EX_WB_write_en_v <= write_en_out_ID_EX;
	FW_rs1_select_v <= rs1_select;
	FW_rs2_select_v <= rs2_select;
	FW_rs3_select_v <= rs3_select;
	ID_EX_instr_imme_v <= instr_imme;
	ID_EX_instr_opcode_v <= instr_opcode;
	ID_EX_instr_rd_v <= instr_rd;
	ID_EX_load_flag_v <= load_rf;
	ID_EX_rs1_addr_v <= rs1_rf;
	ID_EX_rs1_data_v <= rs1_data;
	ID_EX_rs2_addr_v <= rs2_rf;
	ID_EX_rs2_data_v <= rs2_data;
	ID_EX_rs3_addr_v <= rs3_rf;
	ID_EX_rs3_data_v <= rs3_data;
	ID_EX_write_en_v <= write_en_out_rf;
	IF_ID_instruction_v <= fetched_instruction;
	WB_write_addr_v <= instr_rd_EX_WB;
	WB_write_data_v <= rd_data_EX_WB;


end Processor_top_level;
