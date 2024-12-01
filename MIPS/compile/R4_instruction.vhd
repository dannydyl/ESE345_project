-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\compile\R4_instruction.vhd
-- Generated   : Sat Nov 30 22:50:43 2024
-- From        : \\Mac\Home\Documents\SBU_2024_Fall\ESE345\ese345_project\ese345_project\MIPS\..\R4_instruction.bde
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

entity R4_instruction is
  port(
       rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       rs3 : in STD_LOGIC_VECTOR(127 downto 0);
       opcode : in STD_LOGIC_VECTOR(2 downto 0);
       rd_out : out STD_LOGIC_VECTOR(127 downto 0)
  );
end R4_instruction;

architecture R4_instruction of R4_instruction is

---- Component declarations -----

component Signed_Integer_Multiply_Add_High_w_Saturation
  port(
       rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       rs3 : in STD_LOGIC_VECTOR(127 downto 0);
       rd : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component Signed_Integer_Multiply_ADD_LOW_w_Saturation
  port(
       rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       rs3 : in STD_LOGIC_VECTOR(127 downto 0);
       rd : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component Signed_Integer_Multiply_Subtract_High_w_Saturation
  port(
       rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       rs3 : in STD_LOGIC_VECTOR(127 downto 0);
       rd : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component Signed_Integer_Multiply_Subtract_Low_w_Saturation
  port(
       rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       rs3 : in STD_LOGIC_VECTOR(127 downto 0);
       rd : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component Signed_Long_Integer_Multiply_Add_High_w_Saturation
  port(
       rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       rs3 : in STD_LOGIC_VECTOR(127 downto 0);
       rd : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component Signed_Long_Integer_Multiply_Add_Low_w_Saturation
  port(
       rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       rs3 : in STD_LOGIC_VECTOR(127 downto 0);
       rd : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component Signed_Long_Integer_Multiply_Subtract_High_w_Saturation
  port(
       rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       rs3 : in STD_LOGIC_VECTOR(127 downto 0);
       rd : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component Signed_Long_Integer_Multiply_Subtract_Low_w_Saturation
  port(
       rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       rs3 : in STD_LOGIC_VECTOR(127 downto 0);
       rd : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;

---- Signal declarations used on the diagram ----

signal result_000 : STD_LOGIC_VECTOR(127 downto 0);
signal result_001 : STD_LOGIC_VECTOR(127 downto 0);
signal result_010 : STD_LOGIC_VECTOR(127 downto 0);
signal result_011 : STD_LOGIC_VECTOR(127 downto 0);
signal result_100 : STD_LOGIC_VECTOR(127 downto 0);
signal result_101 : STD_LOGIC_VECTOR(127 downto 0);
signal result_110 : STD_LOGIC_VECTOR(127 downto 0);
signal result_111 : STD_LOGIC_VECTOR(127 downto 0);

begin

---- User Signal Assignments ----
with opcode select rd_out <= result_000 when "000", result_001 when "001", result_010 when "010", result_011 when "011", result_100 when "100", result_101 when "101", result_110 when "110", result_111 when "111", (others => '0') when others;

----  Component instantiations  ----

SIMAHS_inst : Signed_Integer_Multiply_Add_High_w_Saturation
  port map(
       rs1 => rs1,
       rs2 => rs2,
       rs3 => rs3,
       rd => result_001
  );

SIMALS_inst : Signed_Integer_Multiply_ADD_LOW_w_Saturation
  port map(
       rs1 => rs1,
       rs2 => rs2,
       rs3 => rs3,
       rd => result_000
  );

SIMSHS_inst : Signed_Integer_Multiply_Subtract_High_w_Saturation
  port map(
       rs1 => rs1,
       rs2 => rs2,
       rs3 => rs3,
       rd => result_011
  );

SIMSLS_inst : Signed_Integer_Multiply_Subtract_Low_w_Saturation
  port map(
       rs1 => rs1,
       rs2 => rs2,
       rs3 => rs3,
       rd => result_010
  );

SLIMAHS_inst : Signed_Long_Integer_Multiply_Add_High_w_Saturation
  port map(
       rs1 => rs1,
       rs2 => rs2,
       rs3 => rs3,
       rd => result_101
  );

SLIMALS_inst : Signed_Long_Integer_Multiply_Add_Low_w_Saturation
  port map(
       rs1 => rs1,
       rs2 => rs2,
       rs3 => rs3,
       rd => result_100
  );

SLIMSHS_inst : Signed_Long_Integer_Multiply_Subtract_High_w_Saturation
  port map(
       rs1 => rs1,
       rs2 => rs2,
       rs3 => rs3,
       rd => result_111
  );

SLIMSLS_inst : Signed_Long_Integer_Multiply_Subtract_Low_w_Saturation
  port map(
       rs1 => rs1,
       rs2 => rs2,
       rs3 => rs3,
       rd => result_110
  );


end R4_instruction;
