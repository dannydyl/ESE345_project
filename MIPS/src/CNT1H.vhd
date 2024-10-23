-------------------------------------------------------------------------------
--
-- Title       : CNT1H
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : //Mac/Home/Documents/SBU_2024_Fall/ESE345/ese345_project/ese345_project/MIPS/src/CNT1H.vhd
-- Generated   : Wed Oct 23 14:43:47 2024
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

entity CNT1H is
	port(
		input_hw : in std_logic_vector(127 downto 0);	 -- input should be 8 and output also should be 8
		output_count : out std_logic_vector(127 downto 0)
	);
end CNT1H;

architecture CNT1H of CNT1H is
	signal input_hw_index7 : std_logic_vector(15 downto 0);
	signal input_hw_index6 : std_logic_vector(15 downto 0);
	signal input_hw_index5 : std_logic_vector(15 downto 0);
	signal input_hw_index4 : std_logic_vector(15 downto 0);
	signal input_hw_index3 : std_logic_vector(15 downto 0);
	signal input_hw_index2 : std_logic_vector(15 downto 0);
	signal input_hw_index1 : std_logic_vector(15 downto 0);
	signal input_hw_index0 : std_logic_vector(15 downto 0);
	signal output_count_index7 : std_logic_vector(15 downto 0);
	signal output_count_index6 : std_logic_vector(15 downto 0);
	signal output_count_index5 : std_logic_vector(15 downto 0);
	signal output_count_index4 : std_logic_vector(15 downto 0);
	signal output_count_index3 : std_logic_vector(15 downto 0);
	signal output_count_index2 : std_logic_vector(15 downto 0);
	signal output_count_index1 : std_logic_vector(15 downto 0);
	signal output_count_index0 : std_logic_vector(15 downto 0);
begin
	input_hw_index7 <= input_hw(127 downto 112);
	input_hw_index6 <= input_hw(111 downto 96);
	input_hw_index5 <= input_hw(95 downto 80);
	input_hw_index4 <= input_hw(79 downto 64);
	input_hw_index3 <= input_hw(63 downto 48);
	input_hw_index2 <= input_hw(47 downto 32);
	input_hw_index1 <= input_hw(31 downto 16);
	input_hw_index0 <= input_hw(15 downto 0);

	process(input_hw_index7)
	variable count : integer := 0;
  begin
		for i in 15 downto 0 loop
			if input_hw_index7(i) = '1' then
				count := count + 1;
			end if;
		end loop;
		output_count_index7 <= std_logic_vector(to_unsigned(count, 16));
	end process;

	process(input_hw_index6)
	variable count : integer := 0;
  begin
		for i in 15 downto 0 loop
			if input_hw_index6(i) = '1' then
				count := count + 1;
			end if;
		end loop;
		output_count_index6 <= std_logic_vector(to_unsigned(count, 16));
	end process;

	process(input_hw_index5)
  begin
		for i in 15 downto 0 loop
			if input_hw_index5(i) = '1' then
				count := count + 1;
			end if;
		end loop;
		output_count_index5 <= std_logic_vector(to_unsigned(count, 16));
	end process;

	process(input_hw_index4)
	variable count : integer := 0;
	begin
		for i in 15 downto 0 loop
			if input_hw_index4(i) = '1' then
				count := count + 1;
			end if;
		end loop;
		output_count_index4 <= std_logic_vector(to_unsigned(count, 16));
	end process;

	process(input_hw_index3)
	variable count : integer := 0;
	begin
		for i in 15 downto 0 loop
			if input_hw_index3(i) = '1' then
				count := count + 1;
			end if;
		end loop;
		output_count_index3 <= std_logic_vector(to_unsigned(count, 16));
	end process;

	process(input_hw_index2)
	variable count : integer := 0;
	begin
		for i in 15 downto 0 loop
			if input_hw_index2(i) = '1' then
				count := count + 1;
			end if;
		end loop;
		output_count_index2 <= std_logic_vector(to_unsigned(count, 16));
	end process;

	process(input_hw_index1)
	variable count : integer := 0;
	begin
		for i in 15 downto 0 loop
			if input_hw_index1(i) = '1' then
				count := count + 1;
			end if;
		end loop;
		output_count_index1 <= std_logic_vector(to_unsigned(count, 16));
	end process;

	process(input_hw_index0)
	variable count : integer := 0;
	begin
		for i in 15 downto 0 loop
			if input_hw_index0(i) = '1' then
				count := count + 1;
			end if;
		end loop;
		output_count_index0 <= std_logic_vector(to_unsigned(count, 16));
	end process;

	output_count <= output_count_index7 & output_count_index6 & output_count_index5 & output_count_index4 & output_count_index3 & output_count_index2 & output_count_index1 & output_count_index0;


end CNT1H;
