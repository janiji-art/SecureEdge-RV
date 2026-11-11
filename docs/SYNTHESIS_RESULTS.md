# SecureEdge-RV — ALU Synthesis Results

## 1. Purpose

This document records the synthesis-related experiments performed on the
32-bit ALU in the SecureEdge-RV project.

The objectives are to:

- Record the generic synthesis results.
- Document the generated Verilog netlists.
- Record Yosys cell statistics.
- Compare logic-depth measurements from controlled experiments.
- Keep generic synthesis measurements separate from physical timing claims.

## 2. Design Under Evaluation

The baseline design is the 32-bit ALU implemented in:

- `rtl/alu.v`

The ALU supports the following operations:

| Operation | Function |
|---|---|
| ADD | Addition |
| SUB | Subtraction |
| AND | Bitwise AND |
| OR | Bitwise OR |
| XOR | Bitwise XOR |
| SLL | Logical left shift |
| SRL | Logical right shift |
| SRA | Arithmetic right shift |
| SLT | Signed less-than comparison |
| SLTU | Unsigned less-than comparison |

The ALU also provides a zero flag indicating whether the result is zero.

The original RTL is preserved as the baseline for comparison.

## 3. Toolchain

The experiments were performed using:

- Yosys 0.70+ (post-release build)
- Icarus Verilog
- Verilog RTL
- macOS environment

The Yosys version reported by the experiment was:

`Yosys 0.70+post`

## 4. Generated Netlists

The project contains generated netlist files, including:

| File | Description |
|---|---|
| `synth/alu_netlist.v` | Generated generic ALU netlist used for the recorded statistics |
| `synth/alu_gatelevel.v` | Generated gate-level representation used in equivalence and simulation work |

These files represent different synthesis outputs and must not be treated as identical netlists.

The statistics in the next section specifically refer to
`synth/alu_netlist.v`.

## 5. Generic Netlist Statistics

The following results were obtained by reading the generated netlist and
running the Yosys `stat` command.

## 5. Generic Netlist Statistics

The following statistics were obtained by reading the generated
`synth/alu_netlist.v` file and running the Yosys `stat` command.

Command:

```bash
yosys -p "read_verilog synth/alu_netlist.v; hierarchy -top alu; stat"
```

Recorded results:

| Metric | Result |
|---|---:|
| Wires | 2,985 |
| Wire bits | 3,081 |
| Public wires | 1,228 |
| Public wire bits | 1,324 |
| Ports | 5 |
| Port bits | 101 |
| Total generic cells | 1,757 |
| `$and` | 773 |
| `$mux` | 229 |
| `$not` | 508 |
| `$or` | 215 |
| `$xor` | 32 |

These are generic Yosys cell statistics for this particular generated
netlist. They are not FPGA LUT counts, ASIC standard-cell counts,
physical area measurements, or power measurements.

Source log: `synth/alu_statistics.txt`

## 6. Logic-Depth Analysis

Logic depth was investigated using the Yosys `ltp` command.

The longest topological path previously measured in
`synth/alu_netlist.v` was:

`113`

This value belongs specifically to that generated netlist and its
reported synthesis representation.

A separate controlled comparison was also performed on the original
ALU RTL and the experimental zero-tree ALU RTL.

Both were analyzed using the same pre-technology-mapping flow:

```bash
yosys -p "read_verilog rtl/alu.v; hierarchy -check -top alu; proc; opt; flatten; ltp -noff"
```

```bash
yosys -p "read_verilog rtl/alu_zero_tree.v; hierarchy -check -top alu; proc; opt; flatten; ltp -noff"
```

Recorded results:

| Design | Longest topological path |
|---|---:|
| Original ALU RTL | 4 |
| Experimental zero-tree ALU RTL | 10 |

These values are measurements from the generic pre-mapping Yosys
representation. They should not be interpreted as physical gate delays.

The explicit zero-tree expression is represented by individual OR
operators at this stage, whereas the original equality comparison
remains represented as an abstract comparison cell. Therefore, this
comparison does not establish that the zero-tree implementation is
physically slower.

Detailed experimental results are documented in
`docs/ZERO_DETECTOR_ANALYSIS.md`.

## 7. Interpretation and Limitations

The synthesis experiments provide useful information about:

- Generic logic representation.
- Cell counts in a generated netlist.
- Topological logic-depth estimates.
- Differences between synthesis representations.

However, generic Yosys statistics and topological path lengths do not
establish actual hardware timing or physical implementation quality.

The following measurements have not been established by these generic
experiments:

- Propagation delay in nanoseconds.
- Maximum operating frequency.
- Timing slack.
- FPGA resource utilization on a specific device.
- ASIC physical area.
- Power consumption.

Physical timing analysis requires a target FPGA architecture or ASIC
standard-cell library, appropriate timing constraints, and a suitable
implementation and timing-analysis flow.

## 8. Conclusion

The original 32-bit ALU has been synthesized into a generated generic
Verilog netlist, and its Yosys statistics have been recorded.

Separate logic-depth experiments have also been performed to study the
design representation and the experimental zero-detector architecture.

The original RTL remains preserved as the baseline design.

All reported generic synthesis measurements are kept separate from
physical timing and hardware performance claims.

---

**Project:** SecureEdge-RV
**Document:** SYNTHESIS_RESULTS.md
**Status:** Generic synthesis and logic-depth results documented
