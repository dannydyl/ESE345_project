# Pipelined SIMD Multimedia Unit Design

## Overview

This project involves the design and implementation of a **4-stage pipelined multimedia processing unit** using VHDL/Verilog hardware description languages. The unit incorporates a forwarding unit to handle data hazards and is designed with features inspired by SIMD (Single Instruction, Multiple Data) processing for multimedia instructions, similar to the Sony Cell SPU and Intel SSE architectures.

### Project Objectives

1. **Learn VHDL/Verilog**: Gain proficiency in HDL for digital circuit design and implementation.
2. **Understand Pipelining**: Develop and test a clock-edge-sensitive pipeline with four stages:
   - **Instruction Fetch (IF)**
   - **Instruction Decode/Register Read (ID)**
   - **Execution (EX)**
   - **Write Back (WB)**
3. **Design Multimedia Operations**: Implement a reduced instruction set supporting multimedia-specific operations like `Multiply-Add`, `Shift`, and `Add-Unsigned`.

---

## Pipeline Stages

### 1. Instruction Fetch (IF)
- Fetches 25-bit instructions from a 64-entry instruction buffer.
- Updates the Program Counter (PC) to point to the next instruction.

### 2. Instruction Decode/Register Read (ID)
- Decodes the instruction and reads up to three 128-bit register operands.
- Handles register write signals for ensuring write consistency.

### 3. Execute (EX)
- Executes ALU operations such as:
  - **Arithmetic (Add, Subtract)**
  - **Logic (AND, OR)**
  - **Multimedia-specific operations (Multiply-Add with Saturation)**.
- Incorporates a **Forwarding Unit** to resolve data hazards and ensure the most recent data is used.

### 4. Write Back (WB)
- Writes results back to the register file.

---

## Key Modules

1. **Multimedia ALU**
   - Performs SIMD-style arithmetic and logic operations.
   - Supports data saturation and overflow handling.

2. **Register File**
   - 32 registers, each 128-bits wide.
   - Supports simultaneous reads/writes with explicit signal handling.

3. **Instruction Buffer**
   - Stores instructions for execution and increments the PC per cycle.

4. **Forwarding Unit**
   - Resolves Read-After-Write (RAW) data hazards by forwarding the most recent data to dependent instructions.

5. **Pipeline Control**
   - Ensures proper instruction progression through the stages.
   - Handles pipeline stalls and flushes when necessary.

---

## Instruction Set

### Key Instruction Formats

1. **LI (Load Immediate)**: Loads a 16-bit immediate value into a 128-bit register.
2. **Multiply-Add (R4 Format)**: Performs multiply-add or multiply-subtract with saturation.
3. **Arithmetic (R3 Format)**:
   - `AHS`: Add Halfword Saturated.
   - `AU`: Add Unsigned.
   - `SFHS`: Subtract Halfword Saturated.

---
