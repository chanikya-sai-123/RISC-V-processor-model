# Five-Stage Pipelined MIPS Processor – Verilog

This project implements a five-stage pipelined MIPS-like processor using Verilog HDL. The design follows the IF, ID, EX, MEM, and WB stages with dual-phase clocking and automatic NOP insertion to handle load-use data hazards.

The processor includes instruction memory, data memory, 32-register register file, ALU, and full pipeline register support. A self-checking testbench is provided to initialize registers, load instructions, and verify execution through simulation.



design file- design_code.v

testbench file -testbench_code.v



Tools: Vivado

Author: Chanikya
