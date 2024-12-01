-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\compile\ALU_top_level.vhd
-- Generated   : Sat Nov 30 22:50:27 2024
-- From        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\..\ALU_top_level.bde
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

entity ALU_top_level is
  port(
       input_rs3 : in STD_LOGIC_VECTOR(127 downto 0);
       input_rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       input_rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       instr : in STD_LOGIC_VECTOR(9 downto 0);
       imme : in STD_LOGIC_VECTOR(15 downto 0);
       output_result : out STD_LOGIC_VECTOR(127 downto 0)
  );
end ALU_top_level;

architecture ALU_top_level of ALU_top_level is

---- Component declarations -----

component load_instruction
  port(
       old_rd : in STD_LOGIC_VECTOR(127 downto 0);
       load_index : in STD_LOGIC_VECTOR(2 downto 0);
       immediate : in STD_LOGIC_VECTOR(15 downto 0);
       new_rd : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component R3_instruction
  port(
       opcode : in STD_LOGIC_VECTOR(7 downto 0);
       imme : in STD_LOGIC_VECTOR(4 downto 0);
       a : in STD_LOGIC_VECTOR(127 downto 0);
       b : in STD_LOGIC_VECTOR(127 downto 0);
       result : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component R4_instruction
  port(
       rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       rs3 : in STD_LOGIC_VECTOR(127 downto 0);
       opcode : in STD_LOGIC_VECTOR(2 downto 0);
       rd_out : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;

---- Signal declarations used on the diagram ----

signal instr_type : STD_LOGIC_VECTOR(1 downto 0);
signal Li_output_result : STD_LOGIC_VECTOR(127 downto 0);
signal R3_output_result : STD_LOGIC_VECTOR(127 downto 0);
signal R4_output_result : STD_LOGIC_VECTOR(127 downto 0);

begin

---- User Signal Assignments ----
instr_type <= instr(9 downto 8);
with instr_type select output_result <= R4_output_result when "10", R3_output_result when "11", Li_output_result when others;

----  Component instantiations  ----

R3_type : R3_instruction
  port map(
       opcode(7) => instr(7),
       opcode(6) => instr(6),
       opcode(5) => instr(5),
       opcode(4) => instr(4),
       opcode(3) => instr(3),
       opcode(2) => instr(2),
       opcode(1) => instr(1),
       opcode(0) => instr(0),
       imme(4) => imme(9),
       imme(3) => imme(8),
       imme(2) => imme(7),
       imme(1) => imme(6),
       imme(0) => imme(5),
       a => input_rs2,
       b => input_rs1,
       result => R3_output_result
  );

R4_type : R4_instruction
  port map(
       rs1 => input_rs1,
       rs2 => input_rs2,
       rs3 => input_rs3,
       opcode(2) => instr(7),
       opcode(1) => instr(6),
       opcode(0) => instr(5),
       rd_out => R4_output_result
  );

li_type : load_instruction
  port map(
       old_rd => input_rs1,
       load_index(2) => instr(8),
       load_index(1) => instr(7),
       load_index(0) => instr(6),
       immediate => imme,
       new_rd => Li_output_result
  );


end ALU_top_level;
