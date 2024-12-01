-------------------------------------------------------------------------------
--
-- Title       : forwarding_unit
-- Design      : EX_WB
-- Author      : Aritro
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:/My_Designs/345_Part2/forwarding_unit/src/forwarding_unit.vhd
-- Generated   : Thu Nov 28 19:17:34 2024
-- From        : Interface description file
-- By          : ItfToHdl ver. 1.0
--
-------------------------------------------------------------------------------
--
-- Description : A forwarding unit which controls whether to send a signal to
--				 a forwarding mux to control whether to forward the output at
--				 the execute or writeback stage for each register rs1, rs2, and rs3 
--               
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.NUMERIC_STD.ALL;

entity forwarding_unit is
	port (
	instr_type : in std_logic_vector(1 downto 0);		-- instruction type
	instruction_WB : in std_logic_vector(4 downto 0);	-- instruction at the writeback stage
	rd_addr_EX : in std_logic_vector(4 downto 0);		-- rd address at the execute stage
	rs1_addr_EX : in std_logic_vector(4 downto 0);	-- instruction at the execute stage
	rs2_addr_EX : in std_logic_vector(4 downto 0);	
	rs3_addr_EX : in std_logic_vector(4 downto 0);	
	write_en_EX : in std_logic;								-- write enable signal
	load_flag_in : in std_logic;								-- load flag signal
	rs1_select : out std_logic;							
	rs2_select : out std_logic;							
	rs3_select : out std_logic			
	);
end forwarding_unit;

architecture behavioral of forwarding_unit is
begin
	process (all) 
	variable forward_enable : std_logic;
	begin
		if write_en_EX = '0' then  -- Don't forward nop instructions
			forward_enable := '0';	
		else	
			forward_enable := '1';	
		end if;
		
		-- Compare ID/EX pipeline register to forwarded value 
		
		if load_flag_in = '1' and instruction_WB = rd_addr_EX and forward_enable = '1' then	-- Comparing rd_wb with rd_ex for load immediate instruction
			rs1_select <= '1';
		else 
			rs1_select <= '0';
		end if;
			
		
		if load_flag_in = '0' and instruction_WB = rs1_addr_EX and forward_enable = '1' then	-- Comparing rd with rs1
			rs1_select <= '1';																		-- Sends signal to forwarding multiplxer for forwarding																										
		else
			rs1_select <= '0';
		end if;
			
		
		if load_flag_in = '0' and instruction_WB = rs2_addr_EX and forward_enable = '1' then	-- Comparing rd with rs2
			rs2_select <= '1';																		
		else
			rs2_select <= '0';
		end if;

		-- when R3 instruction, don't compare rs3
		if instr_type = "11" then
			rs3_select <= '0';
		elsif load_flag_in = '0' and instruction_WB = rs3_addr_EX and forward_enable = '1' then	-- Comparing rd with rs3
			rs3_select <= '1';																		
		else
			rs3_select <= '0';
		end if;
	end process;	 
end behavioral;									