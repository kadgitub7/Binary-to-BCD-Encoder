# Decimal to BCD Encoder | Verilog

![Language](https://img.shields.io/badge/Language-Verilog-blue)
![Tool](https://img.shields.io/badge/Tool-Xilinx%20Vivado-red)
![Type](https://img.shields.io/badge/Type-Combinational%20Logic-green)
![Status](https://img.shields.io/badge/Simulation-Passing-brightgreen)

A Verilog implementation of a **10-input Decimal to BCD Encoder**, designed and simulated in **Xilinx Vivado**.

This document explains:
- What a decimal to BCD encoder is
- How the Boolean expressions are derived without K-maps
- The truth table, implementation details, and simulation results

The project includes the RTL design, testbench, and console-style output verifying correct behavior.

---

## Table of Contents

1. [What Is a Decimal to BCD Encoder?](#what-is-a-decimal-to-bcd-encoder)
2. [How the Encoder Works](#how-the-encoder-works)
3. [Why K-Maps Cannot Be Used](#why-k-maps-cannot-be-used)
4. [Truth Table](#truth-table)
5. [Boolean Expressions](#boolean-expressions)
6. [Verilog Implementation](#verilog-implementation)
7. [Testbench](#testbench)
8. [Testbench Output](#testbench-output)
9. [Running the Project in Vivado](#running-the-project-in-vivado)
10. [Project Files](#project-files)

---

## What Is a Decimal to BCD Encoder?

A **decimal to BCD encoder** is a combinational logic circuit that takes **ten mutually exclusive inputs** — one for each decimal digit (0–9) — and produces a **4-bit Binary Coded Decimal (BCD) output** (`D`, `C`, `B`, `A`).

Each input line represents a single decimal digit. When asserted, the circuit encodes that digit into its equivalent 4-bit binary representation.

> **Assumption:** Exactly one input is active at a time (mutually exclusive inputs).

---

## How the Encoder Works

The encoder maps each of the 10 decimal inputs to a unique 4-bit output:

| Active Input | D | C | B | A | BCD Value |
|:---:|:---:|:---:|:---:|:---:|:---:|
| `zero` | 0 | 0 | 0 | 0 | `0000` |
| `one`  | 0 | 0 | 0 | 1 | `0001` |
| `two`  | 0 | 0 | 1 | 0 | `0010` |
| `three`| 0 | 0 | 1 | 1 | `0011` |
| `four` | 0 | 1 | 0 | 0 | `0100` |
| `five` | 0 | 1 | 0 | 1 | `0101` |
| `six`  | 0 | 1 | 1 | 0 | `0110` |
| `seven`| 0 | 1 | 1 | 1 | `0111` |
| `eight`| 1 | 0 | 0 | 0 | `1000` |
| `nine` | 1 | 0 | 0 | 1 | `1001` |

---

## Why K-Maps Cannot Be Used

Standard K-map simplification requires **binary inputs** arranged across a Karnaugh map grid. In this design, the inputs are **one-hot decimal signals** — not binary variables — so no K-map grid can be constructed. Instead, each output bit is derived by directly observing which input lines cause it to be high.

---

## Truth Table

| Input  | D | C | B | A |
|:------:|:-:|:-:|:-:|:-:|
| `zero` | 0 | 0 | 0 | 0 |
| `one`  | 0 | 0 | 0 | 1 |
| `two`  | 0 | 0 | 1 | 0 |
| `three`| 0 | 0 | 1 | 1 |
| `four` | 0 | 1 | 0 | 0 |
| `five` | 0 | 1 | 0 | 1 |
| `six`  | 0 | 1 | 1 | 0 |
| `seven`| 0 | 1 | 1 | 1 |
| `eight`| 1 | 0 | 0 | 0 |
| `nine` | 1 | 0 | 0 | 1 |

---

## Boolean Expressions

Each output bit is high for the decimal inputs where that bit equals `1` in the corresponding BCD value:

```
D = eight | nine
C = four  | five  | six  | seven
B = two   | three | six  | seven
A = one   | three | five | seven | nine
```

These expressions are read directly from the truth table — `D` is the MSB and is only high for 8 and 9; `A` is the LSB and is high for all odd values.

---
## Circuit Diagram
Below is a circuit diagram taken from NESO Academy. This explains the gates simualted using Verilog in more detail
![Binary BCD Circuit](imageAssets/BinartBCDEncoderCircuit.png)

## Waveform Diagram
Below is a waveform diagram taken when running the simulation using the files in this project
![Binary BCD Circuit](imageAssets/BinartBCDEncoderWaveform.png)

## Verilog Implementation

```verilog
`timescale 1ns / 1ps

module binaryBCD(
    input  zero, one, two, three, four,
    input  five, six, seven, eight, nine,
    output D,
    output C,
    output B,
    output A
    );

    assign D = eight | nine;
    assign C = four  | five  | six   | seven;
    assign B = two   | three | six   | seven;
    assign A = one   | three | five  | seven | nine;

endmodule
```

---

## Testbench

```verilog
`timescale 1ns / 1ps

module binaryBCD_tb();
    reg zero, one, two, three, four;
    reg five, six, seven, eight, nine;
    wire D, C, B, A;

    binaryBCD uut(
        zero, one, two, three, four,
        five, six, seven, eight, nine,
        D, C, B, A
    );

    task clear_inputs;
    begin
        zero  = 0; one   = 0; two   = 0;
        three = 0; four  = 0; five  = 0;
        six   = 0; seven = 0; eight = 0; nine = 0;
    end
    endtask

    initial begin
        clear_inputs; zero  = 1; #10 $display("0 -> %b%b%b%b", D, C, B, A);
        clear_inputs; one   = 1; #10 $display("1 -> %b%b%b%b", D, C, B, A);
        clear_inputs; two   = 1; #10 $display("2 -> %b%b%b%b", D, C, B, A);
        clear_inputs; three = 1; #10 $display("3 -> %b%b%b%b", D, C, B, A);
        clear_inputs; four  = 1; #10 $display("4 -> %b%b%b%b", D, C, B, A);
        clear_inputs; five  = 1; #10 $display("5 -> %b%b%b%b", D, C, B, A);
        clear_inputs; six   = 1; #10 $display("6 -> %b%b%b%b", D, C, B, A);
        clear_inputs; seven = 1; #10 $display("7 -> %b%b%b%b", D, C, B, A);
        clear_inputs; eight = 1; #10 $display("8 -> %b%b%b%b", D, C, B, A);
        clear_inputs; nine  = 1; #10 $display("9 -> %b%b%b%b", D, C, B, A);
    end
endmodule
```

---

## Testbench Output

Console output confirming correct decimal-to-BCD encoding behavior:

```
0 -> 0000
1 -> 0001
2 -> 0010
3 -> 0011
4 -> 0100
5 -> 0101
6 -> 0110
7 -> 0111
8 -> 1000
9 -> 1001
```

**Verification summary:**
- `D` is `1` only for inputs `8` and `9` — the MSB of BCD values ≥ 8
- `C` is `1` for inputs `4` through `7`
- `B` is `1` for inputs `2`, `3`, `6`, and `7`
- `A` is `1` for all odd inputs: `1`, `3`, `5`, `7`, and `9`

---

## Running the Project in Vivado

### 1. Launch Vivado

Open **Xilinx Vivado**.

### 2. Create a New RTL Project

1. Click **Create Project**
2. Select **RTL Project**
3. Optionally enable *Do not specify sources at this time*, or add source files directly

### 3. Add Source Files

| Role              | File               |
|-------------------|--------------------|
| Design Source     | `binaryBCD.v`      |
| Simulation Source | `binaryBCD_tb.v`   |

> Set `binaryBCD_tb.v` as the **simulation top module**.

### 4. Run Behavioral Simulation

Navigate to:

```
Flow → Run Simulation → Run Behavioral Simulation
```

Observe the signals in the waveform viewer:

```
Inputs : zero, one, two, three, four, five, six, seven, eight, nine
Outputs: D, C, B, A
```

Verify that the waveform output matches the truth table and the console output listed above.

---

## Project Files

| File             | Description                                                       |
|------------------|-------------------------------------------------------------------|
| `binaryBCD.v`    | Decimal to BCD encoder RTL module                                 |
| `binaryBCD_tb.v` | Testbench — applies all 10 decimal inputs and displays BCD output |

---

## Author

**Kadhir Ponnambalam**

---

*Designed and simulated using Xilinx Vivado.*
