
# SecureEdge-RV
## 32-Bit ALU Verification Report

### Project Overview
Designed a standalone 32-bit Arithmetic Logic Unit using Verilog HDL.

### Supported Operations
| Operation | Opcode |
|---|---|
| ADD | 0000 |
| SUB | 0001 |
| AND | 0010 |
| OR | 0011 |
| XOR | 0100 |
| SLL | 0101 |
| SRL | 0110 |
| SRA | 0111 |
| SLT | 1000 |
| SLTU | 1001 |

### Development Tools
- Verilog HDL
- Icarus Verilog
- GTKWave
- VS Code

### Verification Results
- Total Tests: 21
- Passed: 21
- Failed: 0

### Conclusion
The 32-bit ALU successfully passed all functional and edge-case verification tests.
The design is ready for RTL synthesis and further hardware analysis.
