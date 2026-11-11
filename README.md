# SecureEdge-RV
## 32-bit Arithmetic Logic Unit (ALU) — Verilog HDL

A standalone 32-bit Arithmetic Logic Unit designed in Verilog HDL. The project covers RTL design, functional simulation, edge-case verification, and generic logic synthesis using Yosys.

> **Current scope:** This repository contains the ALU RTL and its verification flow. FPGA board implementation and physical hardware testing are planned future stages; they are not claimed as completed.

## Project Overview

The ALU accepts two 32-bit operands and a 4-bit operation selector, then produces a 32-bit result and a zero flag.

| Signal | Direction | Width | Description |
|---|---|---:|---|
| `a` | Input | 32 bits | First operand |
| `b` | Input | 32 bits | Second operand |
| `alu_control` | Input | 4 bits | Selects the ALU operation |
| `result` | Output | 32 bits | Result of the selected operation |
| `zero` | Output | 1 bit | High when `result` is zero |

## Supported Operations

| Operation | Control Code | Description |
|---|---|---|
| ADD | `0000` | 32-bit addition |
| SUB | `0001` | 32-bit subtraction |
| AND | `0010` | Bitwise AND |
| OR | `0011` | Bitwise OR |
| XOR | `0100` | Bitwise XOR |
| SLL | `0101` | Logical left shift |
| SRL | `0110` | Logical right shift |
| SRA | `0111` | Arithmetic right shift |
| SLT | `1000` | Signed less-than comparison |
| SLTU | `1001` | Unsigned less-than comparison |

The shift amount is taken from the least significant five bits of operand `b`. Unsupported control codes produce a zero result.

## Architecture

The RTL is organized around combinational operation selection and includes:

1. Arithmetic operations — addition and subtraction
2. Logic operations — AND, OR and XOR
3. Shift operations — SLL, SRL and SRA
4. Comparison operations — signed and unsigned less-than
5. Result selection using the 4-bit control input
6. Zero-flag generation from the selected result

See [ALU Architecture](docs/ALU_ARCHITECTURE.md) for the design notes.

## Repository Structure

```text
SecureEdge-RV/
├── docs/
│   ├── ALU_ARCHITECTURE.md
│   └── ALU_VERIFICATION.md
├── rtl/
│   └── alu.v
├── tb/
│   └── alu_tb.v
└── .gitignore
```

Generated simulation and synthesis outputs are excluded from version control by the `.gitignore` rules. They can be regenerated locally using the tools and commands below.

## Tools Used

- **Verilog HDL** — RTL design
- **Icarus Verilog** — simulation and testbench execution
- **GTKWave** — waveform inspection
- **Yosys** — generic logic synthesis
- **Visual Studio Code** — development environment
- **Git and GitHub** — version control and project hosting

## Simulation and Verification

### 1. Install the tools

Install Icarus Verilog and GTKWave for your operating system. Yosys is required for the synthesis step.

### 2. Compile the RTL and testbench

Run these commands from the repository root:

```bash
iverilog -g2012 -o alu_test rtl/alu.v tb/alu_tb.v
```

### 3. Run the testbench

```bash
vvp alu_test
```

The testbench prints individual PASS/FAIL messages and a final test summary.

### 4. View the waveform

The testbench writes a Value Change Dump file named `alu.vcd`.

```bash
gtkwave alu.vcd
```

### Verification Results

The recorded testbench result is:

| Metric | Result |
|---|---:|
| Total checks | 21 |
| Passed | 21 |
| Failed | 0 |

The testbench covers all ten supported operations, arithmetic and shift edge cases, an invalid control code, and both asserted and deasserted zero-flag conditions.

See [ALU Verification Report](docs/ALU_VERIFICATION.md) for the verification summary.

## Synthesis

Yosys was used for RTL synthesis and netlist generation. The current architecture notes record **1,757 generic logic cells** in the synthesis report.

This is a generic synthesis statistic, not an FPGA-specific LUT count or a measurement of physical device utilization. Actual FPGA resource usage depends on the target device and implementation flow.

A reproducible generic synthesis/statistics run can be started with:

```bash
yosys -p "read_verilog rtl/alu.v; hierarchy -top alu; synth -top alu; stat"
```

## Project Status

| Stage | Status |
|---|---|
| 32-bit ALU RTL design | Complete |
| Functional simulation and testbench | Complete — 21/21 checks passed |
| Yosys synthesis and netlist generation | Complete |
| Git version control and GitHub publication | Complete |
| FPGA architecture learning | Planned / in progress |
| Target-specific FPGA implementation | Planned |
| Physical FPGA board testing | Planned |

## Future Work

- Study FPGA architecture, LUTs, flip-flops, clocking and timing constraints.
- Select a target FPGA board and toolchain.
- Map and implement the ALU for the selected device.
- Review timing and device-specific resource utilization.
- Validate operation on physical FPGA hardware.
- Add implementation reports, waveform captures and hardware demonstration evidence.

## Author

**Jinil Jani**  
GitHub: [@janiji-art](https://github.com/janiji-art)

---

If you find this project useful for learning RTL design and verification, feel free to explore the source code and documentation.
