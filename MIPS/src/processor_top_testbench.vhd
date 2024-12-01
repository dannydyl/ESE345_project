-------------------------------------------------------------------------------
--
-- Title       : processor_top_testbench
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : //Mac/Home/Documents/SBU_2024_Fall/ESE345/ese345_project/ese345_project/MIPS/src/processor_top_testbench.vhd
-- Generated   : Fri Nov 29 18:10:14 2024
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
use STD.textio.all;
use ieee.std_logic_textio.all;

entity processor_top_testbench is
end processor_top_testbench;


architecture processor_top_testbench of processor_top_testbench is
	constant cycle_time : time := 10 ns;

	file instr_file : text;
	file result_file : text;

	signal clk : std_logic;
	signal rst : std_logic;
	signal load_en : std_logic;
	signal instruction : std_logic_vector(24 downto 0);		
	signal done_flag : std_logic;

	-- Signals from Processor_top_level for verification
	signal PC_v : std_logic_vector(5 downto 0);
	signal IF_ID_instruction_v : std_logic_vector(24 downto 0);
	signal ID_EX_instr_opcode_v : std_logic_vector(9 downto 0);
	signal ID_EX_instr_imme_v : std_logic_vector(15 downto 0);
	signal ID_EX_instr_rd_v : std_logic_vector(4 downto 0);
	signal ID_EX_rs1_data_v : std_logic_vector(127 downto 0);
	signal ID_EX_rs2_data_v : std_logic_vector(127 downto 0);
	signal ID_EX_rs3_data_v : std_logic_vector(127 downto 0);
	signal ID_EX_rs1_addr_v : std_logic_vector(4 downto 0);
	signal ID_EX_rs2_addr_v : std_logic_vector(4 downto 0);
	signal ID_EX_rs3_addr_v : std_logic_vector(4 downto 0);
	signal ID_EX_write_en_v : std_logic;
	signal ID_EX_load_flag_v : std_logic;
	signal ALU_result_v : std_logic_vector(127 downto 0);
	signal EX_WB_rd_address_v : std_logic_vector(4 downto 0);
	signal EX_WB_rd_data_v : std_logic_vector(127 downto 0);
	signal EX_WB_write_en_v : std_logic;
	signal WB_write_addr_v : std_logic_vector(4 downto 0);
	signal WB_write_data_v : std_logic_vector(127 downto 0);
begin

	processor_inst : entity work.Processor_top_level
		port map(
			clk => clk,
			rst => rst,
			load_en => load_en,
			instruction => instruction,
			done_flag => done_flag,
			PC_v => PC_v,
			IF_ID_instruction_v => IF_ID_instruction_v,
			ID_EX_instr_opcode_v => ID_EX_instr_opcode_v,
			ID_EX_instr_imme_v => ID_EX_instr_imme_v,
			ID_EX_instr_rd_v => ID_EX_instr_rd_v,
			ID_EX_rs1_data_v => ID_EX_rs1_data_v,
			ID_EX_rs2_data_v => ID_EX_rs2_data_v,
			ID_EX_rs3_data_v => ID_EX_rs3_data_v,
			ID_EX_rs1_addr_v => ID_EX_rs1_addr_v,
			ID_EX_rs2_addr_v => ID_EX_rs2_addr_v,
			ID_EX_rs3_addr_v => ID_EX_rs3_addr_v,
			ID_EX_write_en_v => ID_EX_write_en_v,
			ID_EX_load_flag_v => ID_EX_load_flag_v,
			ALU_result_v => ALU_result_v,
			EX_WB_rd_address_v => EX_WB_rd_address_v,
			EX_WB_rd_data_v => EX_WB_rd_data_v,
			EX_WB_write_en_v => EX_WB_write_en_v,
			WB_write_addr_v => WB_write_addr_v,
			WB_write_data_v => WB_write_data_v
		);

	clock: process
	begin
		loop
			clk <= '0';
			wait for cycle_time/2;
			clk <= '1';
			wait for cycle_time/2;
		end loop;
	end process clock;

	feeding_instructions: process
	variable instr_line : line;
	variable instr_temp : std_logic_vector(24 downto 0);
	variable result_line : line;
	begin
		file_open(instr_file, "\\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\output.txt", read_mode);
		file_open(result_file, "\\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\\result.txt", write_mode);
		
		rst <= '1';
		wait for 2*cycle_time;


		while not endfile(instr_file) loop 
			load_en <= '1';
			rst <= '0';
			readline(instr_file, instr_line);
			read(instr_line, instr_temp);
			
			instruction <= instr_temp;
			
			wait until rising_edge(clk);
			
		end loop;
		
		load_en <= '0';

		report "Done loading instructions into instr_buffer";
		-- Wait for done_flag to be asserted
		wait until falling_edge(done_flag);

		-- Start writing results to result.txt
		report "Writing results to result.txt";
		loop
				-- Write formatted output to file 
				write(result_line, string'("[PC]: " & to_string(PC_v) & LF & LF));
				write(result_line, string'("[IF] Instruction: " & to_string(IF_ID_instruction_v) & LF & LF));
				write(result_line, string'("[ID] Opcode: " & to_string(ID_EX_instr_opcode_v) & LF));
				write(result_line, string'("[ID] Immediate: " & to_string(ID_EX_instr_imme_v) & LF));
				write(result_line, string'("[ID] rd: " & to_string(ID_EX_instr_rd_v) & LF));
				write(result_line, string'("[ID] rs1 Data: " & to_string(ID_EX_rs1_data_v) & LF));
				write(result_line, string'("[ID] rs2 Data: " & to_string(ID_EX_rs2_data_v) & LF));
				write(result_line, string'("[ID] rs3 Data: " & to_string(ID_EX_rs3_data_v) & LF));
				write(result_line, string'("[ID] rs1 Address: " & to_string(ID_EX_rs1_addr_v) & LF));
				write(result_line, string'("[ID] rs2 Address: " & to_string(ID_EX_rs2_addr_v) & LF));
				write(result_line, string'("[ID] rs3 Address: " & to_string(ID_EX_rs3_addr_v) & LF));
				write(result_line, string'("[ID] Write Enable: " & to_string(ID_EX_write_en_v) & LF));
				write(result_line, string'("[ID] Load Flag: " & to_string(ID_EX_load_flag_v) & LF & LF));
				write(result_line, string'("[EXE] ALU Result: " & to_string(ALU_result_v) & LF));
				write(result_line, string'("[EXE] rd Address: " & to_string(EX_WB_rd_address_v) & LF));
				write(result_line, string'("[EXE] rd Data: " & to_string(EX_WB_rd_data_v) & LF));
				write(result_line, string'("[EXE] Write Enable: " & to_string(EX_WB_write_en_v) & LF & LF));
				write(result_line, string'("[WB] Write Address: " & to_string(WB_write_addr_v) & LF));
				write(result_line, string'("[WB] Write Data: " & to_string(WB_write_data_v) & LF));
				
				-- Add a blank line between different PC states
				write(result_line, string'(LF & LF));
				writeline(result_file, result_line);

				-- Wait for next clock edge to observe changes in signals
				wait until rising_edge(clk);
				end loop;
				file_close(result_file);
		wait;
		--std.env.stop;
	end process feeding_instructions;		  
	
		-- Keep simulation running
	idle_process: process
	begin
			wait; -- Wait indefinitely
	end process idle_process;
	

end processor_top_testbench;
