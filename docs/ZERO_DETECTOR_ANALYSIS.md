
# SecureEdge-RV — Zero Detector Architecture Analysis

**Project:** SecureEdge-RV
**Component:** 32-Bit ALU Zero Detector
**HDL:** Verilog
**Synthesis Tool:** Yosys 0.70+
**Analysis Type:** Generic Logic Synthesis and Topological Depth Comparison

---

## 1. Objective

The objective of this experiment is to investigate whether an explicitly balanced OR-tree architecture can improve the implementation of the ALU's 32-bit zero detector compared with a conventional equality-based implementation.

The zero detector determines whether the ALU result is equal to zero.

## 2. Implementations Evaluated

### 2.1 Equality-Based Detector

The original ALU uses:

```verilog
assign zero = (result == 32'b0);
```

This implementation relies on Verilog equality comparison to detect an all-zero 32-bit result.

### 2.2 Explicit Balanced OR-Tree Detector

The experimental implementation uses a hierarchical reduction structure.

The 32 input bits are combined through successive levels:

| Level | Number of OR outputs |
|---|---:|
| Level 1 | 16 |
| Level 2 | 8 |
| Level 3 | 4 |
| Level 4 | 2 |
| Level 5 | 1 |

The final output is inverted to generate the zero flag.

The experimental module is available in:

`rtl/zero_detector_compare.v`

## 3. Functional Verification

Both implementations were evaluated using the ALU testbench.

Results:

| Implementation | Total Tests | Passed | Failed |
|---|---:|---:|---:|
| Original equality detector | 1,019 | 1,019 | 0 |
| Experimental zero-tree ALU | 1,019 | 1,019 | 0 |

The testbench checks the zero flag against the expected ALU result.

## 4. Synthesis Methodology

Both zero detector modules were synthesized using the same Yosys command sequence:

```bash
yosys -p "read_verilog rtl/zero_detector_compare.v; hierarchy -check -top zero_detector_eq; proc; opt; techmap; opt; stat"
```

For the balanced tree:

```bash
yosys -p "read_verilog rtl/zero_detector_compare.v; hierarchy -check -top zero_detector_tree; proc; opt; techmap; opt; stat"
```

The same generic mapping procedure was used for both implementations.

## 5. Synthesis Results

### 5.1 Generic Cell Statistics

| Metric | Equality Detector | Balanced Tree |
|---|---:|---:|
| Total cells | 32 | 32 |
| OR cells | 31 | 31 |
| NOT cells | 1 | 1 |

Both implementations produced identical generic cell counts.

### 5.2 Mapped Topological Depth

The depth comparison was performed using:

```bash
yosys -p "read_verilog rtl/zero_detector_compare.v; hierarchy -check -top zero_detector_eq; proc; opt; techmap; opt; flatten; ltp -noff -select; select -list"
```

The equivalent command was executed with `zero_detector_tree` as the top module.

Results:

| Implementation | Topological Depth |
|---|---:|
| Equality Detector | 6 |
| Balanced Tree | 6 |

Both implementations produced the same mapped topological depth.

## 6. Engineering Analysis

The experiment demonstrates that explicitly describing a balanced OR-tree does not necessarily improve the resulting synthesized logic.

Yosys converts the equality-based zero comparison into a reduction network during technology-independent mapping.

The manually constructed tree also maps into 31 OR cells and one NOT cell.

Therefore, the experimental implementation did not demonstrate an improvement in either generic mapped cell count or topological depth.

## 7. Design Decision

The original equality-based implementation is retained:

```verilog
assign zero = (result == 32'b0);
```

Reasons:

- Simpler and more readable RTL.
- Correct functional behavior.
- Successful verification.
- Identical generic mapped cell count.
- Identical mapped topological depth in this experiment.

The experimental implementation remains available for future research and comparison.

## 8. Limitations

The reported topological depth is not physical propagation delay.

The Yosys generic mapping results do not establish:

- Actual delay in nanoseconds.
- Maximum operating frequency.
- Timing slack.
- Power consumption.
- Physical area on a specific FPGA or ASIC technology.

These measurements require a target technology, suitable cell library or FPGA architecture, timing constraints, and technology-specific implementation and timing analysis.

## 9. Conclusion

The zero detector investigation successfully verified two functionally equivalent implementations.

The equality-based detector and explicitly balanced OR-tree achieved identical generic mapped cell counts and topological depths in the tested Yosys flow.

Based on the available evidence, the original equality-based implementation remains the preferred design.

---

**Document:** ZERO_DETECTOR_ANALYSIS.md
**Project:** SecureEdge-RV
**Status:** Experimental analysis completed

## 8. Post-Technology-Mapping Comparison

Both isolated zero-detector implementations were evaluated using
the same Yosys flow:

`proc; opt; techmap; opt; flatten; ltp -noff`

Recorded results:

| Metric | Equality Detector | Balanced OR Tree |
|---|---:|---:|
| Generic cells | 32 | 32 |
| OR gates | 31 | 31 |
| NOT gates | 1 | 1 |
| Longest topological path | 6 | 6 |

The equality-based implementation and the explicitly balanced
OR-tree implementation have identical generic cell counts and
identical mapped topological path lengths in this experiment.

Therefore, the balanced OR-tree implementation did not demonstrate
a logic-depth or generic cell-count improvement over the equality
operator.

The original equality-based zero detector is retained as the
baseline implementation.

These measurements represent generic Yosys logic primitives.
They do not establish physical propagation delay, maximum clock
frequency, FPGA resource utilization, ASIC area, or power.

Reproducibility logs:

- `synth/zero_eq_depth.log`
- `synth/zero_tree_depth.log`
- `synth/zero_eq_stats.log`
- `synth/zero_tree_stats.log`
