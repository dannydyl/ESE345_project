-------------------------------------------------------------------------------
--
-- Title       : op_package
-- Design      : MIPS
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : //Mac/Home/Documents/SBU_2024_Fall/ESE345/ese345_project/ese345_project/MIPS/src/op_package.vhd
-- Generated   : Tue Oct 22 15:56:14 2024
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

package op_package is	  
	constant OP_NOP    : std_logic_vector(3 downto 0) := "0000";  -- NOP
    constant OP_SLHI   : std_logic_vector(3 downto 0) := "0001";  -- SLHI: shift left halfword immediate
    constant OP_AU     : std_logic_vector(3 downto 0) := "0010";  -- AU: add word unsigned
    constant OP_CNTIH  : std_logic_vector(3 downto 0) := "0011";  -- CNTIH: count 1s in halfwords
    constant OP_AHS    : std_logic_vector(3 downto 0) := "0100";  -- AHS: add halfword saturated
    constant OP_AND    : std_logic_vector(3 downto 0) := "0101";  -- AND: bitwise logical and
    constant OP_BCW    : std_logic_vector(3 downto 0) := "0110";  -- BCW: broadcast word
    constant OP_MAXWS  : std_logic_vector(3 downto 0) := "0111";  -- MAXWS: max signed word
    constant OP_MINWS  : std_logic_vector(3 downto 0) := "1000";  -- MINWS: min signed word
    constant OP_MLHU   : std_logic_vector(3 downto 0) := "1001";  -- MLUH: multiply low unsigned
    constant OP_MLHCU   : std_logic_vector(3 downto 0) := "1010";  -- MLHU: multiply low by constant unsigned
    constant OP_OR     : std_logic_vector(3 downto 0) := "1011";  -- OR: bitwise logical or
    constant OP_CLZH   : std_logic_vector(3 downto 0) := "1100";  -- CLZH: count leading zeroes in halfwords
    constant OP_RLH    : std_logic_vector(3 downto 0) := "1101";  -- RLH: rotate left bits in halfwords
    constant OP_SFWU   : std_logic_vector(3 downto 0) := "1110";  -- SFWU: subtract from word unsigned	
	constant OP_SFHS   : std_logic_vector(3 downto 0) := "1111";  -- SFHS: subtract from halfword saturated
	
end package op_package;

