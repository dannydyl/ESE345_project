-------------------------------------------------------------------------------
--
-- Title       : forwarding_mux
-- Design      : EX_WB
-- Author      : Aritro
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:/My_Designs/345_Part2/EX_WB/src/forwarding_mux.vhd
-- Generated   : Thu Nov 28 19:17:34 2024
-- From        : Interface description file
-- By          : ItfToHdl ver. 1.0
--
-------------------------------------------------------------------------------
--
-- Description : A forwarding multiplexer which controls whether rs1, rs2, and rs3 come 
--               from the register file or is forwarded from the EX_WB Pipeline Register
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.NUMERIC_STD.ALL;

entity forwarding_mux is
	port(
	rs1_reg : in std_logic_vector(127 downto 0);	    -- rs1 from register file
	rs2_reg : in std_logic_vector(127 downto 0);		-- rs2 from register file
	rs3_reg : in std_logic_vector(127 downto 0);		-- rs3 from register file
	
	rd_EX_WB : in std_logic_vector(127 downto 0);		-- rs1 forwarded from EX-WB pipeline register
	
	rs1_select : in std_logic;							-- select signal for rs1 
	rs2_select : in std_logic;							-- select signal for rs2 
	rs3_select : in std_logic;							-- select signal for rs3
		
	rs1 : out std_logic_vector(127 downto 0);			-- final value for rs1 
	rs2 : out std_logic_vector(127 downto 0);			-- final value for rs2
	rs3 : out std_logic_vector(127 downto 0)			-- final value for rs3
	);
end forwarding_mux;

architecture behavioral of forwarding_mux is
begin 
	process(all)
	begin
		if rs1_select = '1' then
			rs1 <= rd_EX_WB;
		else
			rs1 <= rs1_reg;
		end if;
	
		if rs2_select = '1' then
			rs2 <= rd_EX_WB;
		else
			rs2 <= rs2_reg;
		end if;
	
		if rs3_select = '1' then
			rs3 <= rd_EX_WB;
		else
			rs3 <= rs3_reg;
		end if;
	end process; 
end behavioral;
