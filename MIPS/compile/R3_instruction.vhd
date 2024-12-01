-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\compile\R3_instruction.vhd
-- Generated   : Sat Nov 30 22:50:41 2024
-- From        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\..\R3_instruction.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library mips;
use mips.op_package.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity R3_instruction is
  port(
       opcode : in STD_LOGIC_VECTOR(7 downto 0);
       imme : in STD_LOGIC_VECTOR(4 downto 0);
       a : in STD_LOGIC_VECTOR(127 downto 0);
       b : in STD_LOGIC_VECTOR(127 downto 0);
       result : out STD_LOGIC_VECTOR(127 downto 0)
  );
end R3_instruction;

architecture R3_instruction of R3_instruction is

---- Component declarations -----

component AHS
  port(
       a_input : in STD_LOGIC_VECTOR(127 downto 0);
       b_input : in STD_LOGIC_VECTOR(127 downto 0);
       result_output : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component CLZ
  port(
       input_hw : in STD_LOGIC_VECTOR(127 downto 0);
       output_count : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component CNT1H
  port(
       input_hw : in STD_LOGIC_VECTOR(127 downto 0);
       output_count : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component MAXWS
  port(
       input_a : in STD_LOGIC_VECTOR(127 downto 0);
       input_b : in STD_LOGIC_VECTOR(127 downto 0);
       output_result : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component MINWS
  port(
       input_a : in STD_LOGIC_VECTOR(127 downto 0);
       input_b : in STD_LOGIC_VECTOR(127 downto 0);
       output_result : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component MLHCU
  port(
       input_a : in STD_LOGIC_VECTOR(127 downto 0);
       input_const : in STD_LOGIC_VECTOR(4 downto 0);
       output_result : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component RLH
  port(
       input_a : in STD_LOGIC_VECTOR(127 downto 0);
       input_b : in STD_LOGIC_VECTOR(127 downto 0);
       output_result : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component SFHS
  port(
       input_a : in STD_LOGIC_VECTOR(127 downto 0);
       input_b : in STD_LOGIC_VECTOR(127 downto 0);
       output_result : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;

---- Signal declarations used on the diagram ----

signal shamt : INTEGER := 0;
signal AHS_result : STD_LOGIC_VECTOR(127 downto 0);
signal AU_result : STD_LOGIC_VECTOR(127 downto 0);
signal BCW_result : STD_LOGIC_VECTOR(127 downto 0);
signal CLZ_result : STD_LOGIC_VECTOR(127 downto 0);
signal CNT1H_result : STD_LOGIC_VECTOR(127 downto 0);
signal current_op : STD_LOGIC_VECTOR(3 downto 0);
signal MAXWS_result : STD_LOGIC_VECTOR(127 downto 0);
signal MINWS_result : STD_LOGIC_VECTOR(127 downto 0);
signal MLHCU_result : STD_LOGIC_VECTOR(127 downto 0);
signal MLHU_result : STD_LOGIC_VECTOR(127 downto 0);
signal RLH_result : STD_LOGIC_VECTOR(127 downto 0);
signal SFHS_result : STD_LOGIC_VECTOR(127 downto 0);
signal SFWU_result : STD_LOGIC_VECTOR(127 downto 0);
signal SLHI_result : STD_LOGIC_VECTOR(127 downto 0);

begin

---- User Signal Assignments ----
with current_op select result <= SLHI_result when OP_SLHI, AU_result when OP_AU, CNT1H_result when OP_CNTIH, AHS_result when OP_AHS, a and b when OP_AND, BCW_result when OP_BCW, MAXWS_result when OP_MAXWS, MINWS_result when OP_MINWS, MLHU_result when OP_MLHU, MLHCU_result when OP_MLHCU, a or b when OP_OR, CLZ_result when OP_CLZH, RLH_result when OP_RLH, SFWU_result when OP_SFWU, SFHS_result when OP_SFHS, (others => '0') when others;
current_op <= opcode(3 downto 0);
shamt <= to_integer(unsigned(imme(3 downto 0)));
SLHI_result <= std_logic_vector(shift_left(unsigned(b(127 downto 112)),shamt)) & std_logic_vector(shift_left(unsigned(b(111 downto 96)),shamt)) & std_logic_vector(shift_left(unsigned(b(95 downto 80)),shamt)) & std_logic_vector(shift_left(unsigned(b(79 downto 64)),shamt)) & std_logic_vector(shift_left(unsigned(b(63 downto 48)),shamt)) & std_logic_vector(shift_left(unsigned(b(47 downto 32)),shamt)) & std_logic_vector(shift_left(unsigned(b(31 downto 16)),shamt)) & std_logic_vector(shift_left(unsigned(b(15 downto 0)),shamt));
AU_result <= std_logic_vector(unsigned(a(127 downto 96)) + unsigned(b(127 downto 96))) & std_logic_vector(unsigned(a(95 downto 64)) + unsigned(b(95 downto 64))) & std_logic_vector(unsigned(a(63 downto 32)) + unsigned(b(63 downto 32))) & std_logic_vector(unsigned(a(31 downto 0)) + unsigned(b(31 downto 0)));
BCW_result <= b(31 downto 0) & b(31 downto 0) & b(31 downto 0) & b(31 downto 0);
MLHU_result <= std_logic_vector(unsigned(a(111 downto 96)) * unsigned(b(111 downto 96))) & std_logic_vector(unsigned(a(79 downto 64)) * unsigned(b(79 downto 64))) & std_logic_vector(unsigned(a(47 downto 32)) * unsigned(b(47 downto 32))) & std_logic_vector(unsigned(a(15 downto 0)) * unsigned(b(15 downto 0)));
SFWU_result <= std_logic_vector(unsigned(a(127 downto 96)) - unsigned(b(127 downto 96))) & std_logic_vector(unsigned(a(95 downto 64)) - unsigned(b(95 downto 64))) & std_logic_vector(unsigned(a(63 downto 32)) - unsigned(b(63 downto 32))) & std_logic_vector(unsigned(a(31 downto 0)) - unsigned(b(31 downto 0)));

----  Component instantiations  ----

AHS_module : AHS
  port map(
       a_input => a,
       b_input => b,
       result_output => AHS_result
  );

CLZH_module : CLZ
  port map(
       input_hw => b,
       output_count => CLZ_result
  );

CNT1H_module : CNT1H
  port map(
       input_hw => b,
       output_count => CNT1H_result
  );

MAXWS_module : MAXWS
  port map(
       input_a => a,
       input_b => b,
       output_result => MAXWS_result
  );

MINWS_module : MINWS
  port map(
       input_a => a,
       input_b => b,
       output_result => MINWS_result
  );

MLHCU_module : MLHCU
  port map(
       input_a => b,
       input_const => imme,
       output_result => MLHCU_result
  );

RLH_module : RLH
  port map(
       input_a => a,
       input_b => b,
       output_result => RLH_result
  );

SFHS_module : SFHS
  port map(
       input_a => a,
       input_b => b,
       output_result => SFHS_result
  );


end R3_instruction;
