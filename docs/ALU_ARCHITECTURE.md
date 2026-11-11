# 32-Bit ALU Architecture

## Overview
A 32-bit Arithmetic Logic Unit designed using
Verilog HDL.

## Input Signals
- A: 32-bit operand
- B: 32-bit operand
- ALU Control: 4-bit operation selector

## Output Signals
- Result: 32-bit output
- Zero: Zero detection flag

## Functional Units
1. Arithmetic Unit
2. Logical Unit
3. Shift Unit
4. Comparison Unit
5. Result Selection Logic
6. Zero Flag Generator

## Supported Operations
ADD, SUB, AND, OR, XOR,
SLL, SRL, SRA, SLT, SLTU

## Verification
- Total Tests: 21
- Passed: 21
- Failed: 0

## Synthesis
Tool: Yosys
Generic Logic Cells: 1757