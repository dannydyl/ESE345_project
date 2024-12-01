-------------------------------------------------------------------------------
--
-- Title       : Register_file
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : //Mac/Home/Documents/SBU_2024_Fall/ESE345/ese345_project/ese345_project/MIPS/src/Register_file.vhd
-- Generated   : Tue Nov 26 22:41:11 2024
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

entity Register_file is
	port(
		clk : in std_logic;
		rst : in std_logic;

		instruction : in std_logic_vector(24 downto 0);
		
		reg_write_en : in std_logic;
		reg_write_addr : in std_logic_vector(4 downto 0);
		reg_write_data : in std_logic_vector(127 downto 0);
		
		reg_read_addr1 : in std_logic_vector(4 downto 0);
		reg_read_addr2 : in std_logic_vector(4 downto 0);
		reg_read_addr3 : in std_logic_vector(4 downto 0);

		reg_read_data1 : out std_logic_vector(127 downto 0);
		reg_read_data2 : out std_logic_vector(127 downto 0);
		reg_read_data3 : out std_logic_vector(127 downto 0);

		reg_rs1_addr_out : out std_logic_vector(4 downto 0);
		reg_rs2_addr_out : out std_logic_vector(4 downto 0);
		reg_rs3_addr_out : out std_logic_vector(4 downto 0);

		instr_opcode : out std_logic_vector(9 downto 0);
		instr_imme : out std_logic_vector(15 downto 0);
		instr_rd : out std_logic_vector(4 downto 0);
		write_en_out : out std_logic;
		load_flag_out : out std_logic
	);
end Register_file;

architecture Register_file of Register_file is
	type register_file is array(0 to 31) of std_logic_vector(127 downto 0);
	signal reg_file : register_file;
begin
	
	read : process(reg_read_addr1, reg_read_addr2, reg_read_addr3, reg_write_addr)
	begin
		if reg_write_en = '1' then

				-- if the register is being written and read at the sametime, bypass the data
				if(reg_write_addr = reg_read_addr1) then
					reg_read_data1 <= reg_write_data;
				end if;

				if(reg_write_addr = reg_read_addr2) then
					reg_read_data2 <= reg_write_data;
				end if;

				if(reg_write_addr = reg_read_addr3) then
					reg_read_data3 <= reg_write_data;
				end if;
		else
				reg_read_data1 <= reg_file(to_integer(unsigned(reg_read_addr1)));
				reg_read_data2 <= reg_file(to_integer(unsigned(reg_read_addr2)));
				reg_read_data3 <= reg_file(to_integer(unsigned(reg_read_addr3)));
		end if;			   							 
	end process;
	
	decode : process(instruction)
	begin
		
		if((instruction(18 downto 15) = "0000") AND (instruction(24 downto 23) = "11")) then -- if the instruction is nop then do not write
			write_en_out <= '0';
		else
			write_en_out <= '1';
		end if;

		if(instruction(24) = '0') then -- if instruction is load, then load flag 1
			load_flag_out <= '1';
		else
			load_flag_out <= '0';
		end if;

		instr_opcode <= instruction(24 downto 15);
		instr_imme <= instruction(20 downto 5);
		instr_rd <= instruction(4 downto 0);

		reg_rs1_addr_out <= reg_read_addr1;	  -- for forwarding unit
		reg_rs2_addr_out <= reg_read_addr2;
		reg_rs3_addr_out <= reg_read_addr3;
		
	end process;
	
	write: process(clk, rst)
	begin
		if rst = '1' then
			for i in 0 to 31 loop
				reg_file(i) <= (others => '0');
			end loop;
		elsif rising_edge(clk) then	 
			if reg_write_en = '1' then
				reg_file(to_integer(unsigned(reg_write_addr))) <= reg_write_data;  
			end if;
		end if;
	end process;

end Register_file;
