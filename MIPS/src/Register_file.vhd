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
		
		reg_write_en : in std_logic;
		reg_write_addr : in std_logic_vector(31 downto 0);
		reg_write_data : in std_logic_vector(127 downto 0);
		
		reg_read_addr1 : in std_logic_vector(31 downto 0);
		reg_read_addr2 : in std_logic_vector(31 downto 0);
		reg_read_addr3 : in std_logic_vector(31 downto 0);
		reg_read_data1 : out std_logic_vector(127 downto 0);
		reg_read_data2 : out std_logic_vector(127 downto 0);
		reg_read_data3 : out std_logic_vector(127 downto 0)


	);
end Register_file;

architecture Register_file of Register_file is
	type register_file is array(0 to 31) of std_logic_vector(127 downto 0);
	signal reg_file : register_file;
begin
	process(all)
	begin

	end process;	

	process(clk, rst)
	begin
		if rst = '1' then
			for i in 0 to 31 loop
				reg_file(i) <= (others => '0');
			end loop;
		elsif rising_edge(clk) then

			reg_read_data1 <= reg_file(to_integer(unsigned(reg_read_addr1)));
			reg_read_data2 <= reg_file(to_integer(unsigned(reg_read_addr2)));
			reg_read_data3 <= reg_file(to_integer(unsigned(reg_read_addr3)));

			if reg_write_en = '1' then
				reg_file(to_integer(unsigned(reg_write_addr))) <= reg_write_data;

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

			end if;
		end if;
	end process;

end Register_file;
