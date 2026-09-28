# Verilog HDL – Chapter 03 Labs

This repository contains the **Chapter 03 Verilog HDL laboratory exercises**. The labs focus on combinational and sequential RTL design using different Verilog constructs and demonstrate how common digital building blocks can be implemented and verified.

The chapter includes practical implementations of **multiplexers, comparators, decoders, bit counters, parity generators, arithmetic circuits, and an ALU**.

---

## 📚 Labs Overview

| Lab        | Topic                              | Design Type   | Main Concepts                     |
| ---------- | ---------------------------------- | ------------- | --------------------------------- |
| Lab 3.1(a) | 8:1 Multiplexer – Case Statement   | Combinational | `case` statement                  |
| Lab 3.1(b) | 8:1 Multiplexer – If-Else          | Combinational | `if-else`                         |
| Lab 3.1(c) | 8:1 Multiplexer – Ternary Operator | Combinational | Conditional operator              |
| Lab 3.2    | 8-bit Comparator                   | Combinational | Relational operators              |
| Lab 3.3    | 3:8 Decoder                        | Combinational | Boolean logic / decoding          |
| Lab 3.4    | Bit Counter & First-1 Position     | Sequential    | `for` loop, bit scanning          |
| Lab 3.5    | 32-bit Parity Generator            | Sequential    | Reduction XOR, parity             |
| Lab 3.6    | Multiply by 3                      | Combinational | Shift and addition                |
| Lab 3.7    | 32-bit ALU                         | Sequential    | `case`, arithmetic, logic, shifts |

---

# 🔹 Lab 3.1 – 8:1 Multiplexer

Lab 3.1 implements an **8-to-1 multiplexer** in three different ways.

The purpose is to demonstrate that the same combinational functionality can be described using different Verilog constructs.

### Inputs

There are eight 5-bit data inputs:

```text
a0, a1, a2, a3, a4, a5, a6, a7
```

and a 3-bit select signal:

```text
sel
```

### Output

```text
dout
```

The output is 5 bits wide.

### Selection Table

| `sel` | Selected Input |
| ----- | -------------- |
| `000` | `a0`           |
| `001` | `a1`           |
| `010` | `a2`           |
| `011` | `a3`           |
| `100` | `a4`           |
| `101` | `a5`           |
| `110` | `a6`           |
| `111` | `a7`           |

---

## Lab 3.1(a) – Case Statement

This version implements the multiplexer using a `case` statement.

```verilog
case(sel)
    3'd0: dout = a0;
    3'd1: dout = a1;
    3'd2: dout = a2;
    ...
    3'd7: dout = a7;
endcase
```

### Files

```text
Lab_3_1/
└── Lab_3_1(a)/
    ├── Lab_3_1(a).v
    └── Lab_3_1(a)_tb.v
```

### Concepts

* `case` statement
* Combinational `always` block
* Multiplexer design
* Testbench stimulus
* VCD waveform generation

---

## Lab 3.1(b) – If-Else Implementation

The same 8:1 multiplexer is implemented using an `if-else` chain.

```verilog
if (sel == 3'd0)
    dout = a0;
else if (sel == 3'd1)
    dout = a1;
...
else
    dout = a7;
```

### Files

```text
Lab_3_1/
└── Lab_3_1(b)/
    ├── Lab_3_1(b).v
    └── Lab_3_1(b)_tb.v
```

### Concepts

* `if-else`
* Conditional selection
* Combinational logic
* RTL description

---

## Lab 3.1(c) – Ternary Operator Implementation

The third implementation uses nested conditional/ternary operators.

```verilog
assign dout = (sel == 3'd0) ? a0 :
              (sel == 3'd1) ? a1 :
              (sel == 3'd2) ? a2 :
              ...
              a7;
```

### Files

```text
Lab_3_1/
└── Lab_3_1(c)/
    ├── Lab_3_1(c).v
    └── Lab_3_1(c)_tb.v
```

### Concepts

* Continuous assignment
* Ternary operator
* Combinational logic
* Alternative RTL coding styles

### Verification

All three implementations use the same basic testbench approach. The testbench assigns different values to the eight inputs and cycles `sel` from `0` through `7`.

A VCD waveform is generated:

```text
Mux_8to1.vcd
```

---

# 🔹 Lab 3.2 – 8-bit Comparator

This lab implements an **8-bit magnitude comparator** using Verilog relational operators.

Two 8-bit values, `a` and `b`, are compared to determine whether they are:

* Equal
* Greater than
* Less than

### Inputs

| Signal | Width | Description  |
| ------ | ----- | ------------ |
| `a`    | 8-bit | First input  |
| `b`    | 8-bit | Second input |

### Outputs

| Signal | Description       |
| ------ | ----------------- |
| `EQ`   | `1` when `a == b` |
| `GT`   | `1` when `a > b`  |
| `LT`   | `1` when `a < b`  |

### Implementation

The outputs are generated using continuous assignments:

```verilog
assign EQ = (a == b);
assign GT = a > b;
assign LT = a < b;
```

### Files

```text
Lab_3_2/
├── Lab_3_2.v
└── Lab_3_2_tb.v
```

### Verification

The testbench checks multiple cases including:

* Equal values
* `a > b`
* `a < b`
* Maximum 8-bit values
* Additional greater and less comparisons

A VCD waveform is generated:

```text
comparator_rel.vcd
```

---

# 🔹 Lab 3.3 – 3:8 Decoder

This lab implements a **3-to-8 decoder** with an enable input.

When the decoder is enabled, the 3-bit input selects exactly one of the eight output lines.

### Inputs

| Signal | Width | Description   |
| ------ | ----- | ------------- |
| `din`  | 3-bit | Decoder input |
| `en`   | 1-bit | Enable signal |

### Output

```text
d[7:0]
```

### Decoder Operation

| `en` | `din` | Output     |
| ---- | ----- | ---------- |
| 0    | Any   | `00000000` |
| 1    | `000` | `00000001` |
| 1    | `001` | `00000010` |
| 1    | `010` | `00000100` |
| 1    | `011` | `00001000` |
| 1    | `100` | `00010000` |
| 1    | `101` | `00100000` |
| 1    | `110` | `01000000` |
| 1    | `111` | `10000000` |

### Implementation

The primary implementation uses continuous Boolean assignments for each output bit.

The source file also contains an alternative **`case` statement implementation** in comments.

### Files

```text
Lab_3_3/
├── Lab_3_3.v
└── Lab_3_3_tb.v
```

### Verification

The testbench verifies:

1. Decoder disabled
2. All eight input combinations while enabled
3. Decoder disabled again

A VCD waveform is generated:

```text
decoder_3to8.vcd
```

---

# 🔹 Lab 3.4 – Bit Counter and First-1 Position Detector

This lab processes an **8-bit input value** and determines two things:

1. The total number of `1` bits.
2. The position of the **first `1` bit** found when scanning from bit 0 toward bit 7.

### Inputs

| Signal  | Width | Description |
| ------- | ----- | ----------- |
| `VAL`   | 8-bit | Input value |
| `RESET` | 1-bit | Reset       |
| `CLK`   | 1-bit | Clock       |

### Outputs

| Signal | Width | Description           |
| ------ | ----- | --------------------- |
| `Num`  | 4-bit | Number of `1` bits    |
| `pos`  | 3-bit | Position of first `1` |

### Implementation

The circuit uses a `for` loop to scan all eight bits:

```verilog
for (i = 0; i < 8; i = i + 1)
```

A `found` flag is used to ensure that only the first detected `1` determines `pos`.

### Example

For:

```text
VAL = 10110100
```

there are four `1`s.

Scanning from bit 0:

```text
Bit:  7 6 5 4 3 2 1 0
      1 0 1 1 0 1 0 0
                    ↑
                  first 1
```

Therefore:

```text
Num = 4
pos = 2
```

### Files

```text
Lab_3_4/
├── Lab_3_4.v
└── Lab_3_4_tb.v
```

### Verification

The testbench checks:

* All zeros
* A single `1`
* Multiple `1`s
* All ones
* A value with the first `1` at bit 0
* A value with only bit 7 set

A VCD waveform is generated:

```text
Lab_3_4.vcd
```

---

# 🔹 Lab 3.5 – 32-bit Parity Generator

This lab implements a **32-bit parity generator**.

The 32-bit input is divided into four 8-bit sections, and one parity bit is generated for each section.

### Input

```text
DIN[31:0]
```

### Output

```text
DOUT[35:0]
```

The lower 32 bits contain the original input:

```text
DOUT[31:0] = DIN
```

The upper four bits contain parity values:

```text
DOUT[32] = ^DIN[7:0]
DOUT[33] = ^DIN[15:8]
DOUT[34] = ^DIN[23:16]
DOUT[35] = ^DIN[31:24]
```

### Parity Generation

The reduction XOR operator:

```verilog
^
```

is used to generate the parity bit for each byte.

### Files

```text
Lab_3_5/
├── Lab_3_5.v
└── Lab_3_5_tb.v
```

### Verification

The testbench checks several input patterns including:

```text
00000000
FFFFFFFF
12345678
A5A5A5A5
00000001
```

A VCD waveform is generated:

```text
Parity_Gen.vcd
```

---

# 🔹 Lab 3.6 – Multiply by 3

This lab demonstrates how multiplication by **3** can be implemented using only a shift and an addition.

Mathematically:

```text
x × 3 = (x × 2) + x
```

Since multiplying by 2 is equivalent to shifting left by one bit:

```text
x × 3 = (x << 1) + x
```

### Inputs

| Signal    | Width | Description |
| --------- | ----- | ----------- |
| `mult_in` | 6-bit | Input value |
| `en`      | 1-bit | Enable      |

### Output

| Signal     | Width | Description |
| ---------- | ----- | ----------- |
| `mult_out` | 8-bit | Result      |

### Implementation

The 6-bit input is first extended to 8 bits:

```verilog
ext_mult_in = {2'b00, mult_in};
```

Then:

```verilog
ext_mult = ext_mult_in << 1;
mult_out = ext_mult + ext_mult_in;
```

The extension prevents loss of the most significant bits during the shift.

### Example

For:

```text
mult_in = 10
```

the operation is:

```text
10 << 1 = 20

20 + 10 = 30
```

Therefore:

```text
10 × 3 = 30
```

### Files

```text
Lab_3_6/
├── Lab_3_6.v
└── Lab_3_6_tb.v
```

### Verification

The testbench verifies:

* Disabled operation
* `5 × 3`
* `10 × 3`
* `20 × 3`
* `32 × 3`
* Maximum input: `63 × 3`

A VCD waveform is generated:

```text
mult3.vcd
```

---

# 🔹 Lab 3.7 – 32-bit ALU

This lab implements a **32-bit Arithmetic Logic Unit (ALU)** supporting arithmetic, logical, and shift operations.

The ALU uses a 4-bit opcode to select one of **16 operations**.

### Inputs

| Signal   | Width  | Description        |
| -------- | ------ | ------------------ |
| `rst`    | 1-bit  | Reset              |
| `clk`    | 1-bit  | Clock              |
| `opcode` | 4-bit  | Operation selector |
| `A`      | 32-bit | Operand A          |
| `B`      | 32-bit | Operand B          |

### Output

| Signal | Width  | Description |
| ------ | ------ | ----------- |
| `Dout` | 32-bit | ALU result  |

### ALU Operations

| Opcode | Operation          | Description   |
| ------ | ------------------ | ------------- |
| `0`    | ADD                | `A + B`       |
| `1`    | SUB                | `A - B`       |
| `2`    | NOT A              | `~A`          |
| `3`    | NOT B              | `~B`          |
| `4`    | AND                | `A & B`       |
| `5`    | OR                 | `A \| B`      |
| `6`    | XOR                | `A ^ B`       |
| `7`    | XNOR               | `A ~^ B`      |
| `8`    | NAND               | `~(A & B)`    |
| `9`    | NOR                | `~(A \| B)`   |
| `10`   | Shift A Left       | `A << 1`      |
| `11`   | Shift A Right      | `A >> 1`      |
| `12`   | Shift B Left       | `B << 1`      |
| `13`   | Shift B Right      | `B >> 1`      |
| `14`   | Barrel Shift Left  | `A << B[4:0]` |
| `15`   | Barrel Shift Right | `A >> B[4:0]` |

### Sequential Operation

The ALU output is updated on the rising edge of the clock:

```verilog
always @(posedge clk)
```

When reset is asserted:

```verilog
Dout <= 32'b0;
```

The operation is selected using a `case` statement.

### Barrel Shifter

For the barrel-shift operations, the lower five bits of `B` determine the shift amount:

```verilog
A << B[4:0]
```

or:

```verilog
A >> B[4:0]
```

This allows a shift amount from `0` to `31`.

### Files

```text
Lab_3_7/
├── Lab_3_7.v
└── Lab_3_7_tb.v
```

### Verification

The testbench verifies all 16 ALU operations using:

```text
A = 10
B = 3
```

It also verifies reset operation.

A VCD waveform is generated:

```text
ALU.vcd
```

---

# 📁 Repository Structure

```text
Chap_03_Labs/
│
├── Lab_3_1/
│   ├── Lab_3_1(a)/
│   │   ├── Lab_3_1(a).v
│   │   └── Lab_3_1(a)_tb.v
│   │
│   ├── Lab_3_1(b)/
│   │   ├── Lab_3_1(b).v
│   │   └── Lab_3_1(b)_tb.v
│   │
│   └── Lab_3_1(c)/
│       ├── Lab_3_1(c).v
│       └── Lab_3_1(c)_tb.v
│
├── Lab_3_2/
│   ├── Lab_3_2.v
│   └── Lab_3_2_tb.v
│
├── Lab_3_3/
│   ├── Lab_3_3.v
│   └── Lab_3_3_tb.v
│
├── Lab_3_4/
│   ├── Lab_3_4.v
│   └── Lab_3_4_tb.v
│
├── Lab_3_5/
│   ├── Lab_3_5.v
│   └── Lab_3_5_tb.v
│
├── Lab_3_6/
│   ├── Lab_3_6.v
│   └── Lab_3_6_tb.v
│
└── Lab_3_7/
    ├── Lab_3_7.v
    └── Lab_3_7_tb.v
```

---

# 🛠️ Tools

These labs can be simulated using common Verilog simulation tools:

* **Icarus Verilog**
* **GTKWave**
* **ModelSim / Questa**
* **Vivado Simulator**
* **Verilator**

---

# ▶️ Running the Labs with Icarus Verilog

Navigate to the desired lab directory and compile the Verilog design together with its testbench.

### Lab 3.1(a)

```bash
iverilog -o mux_case "Lab_3_1(a).v" "Lab_3_1(a)_tb.v"
vvp mux_case
gtkwave Mux_8to1.vcd
```

### Lab 3.1(b)

```bash
iverilog -o mux_ifelse "Lab_3_1(b).v" "Lab_3_1(b)_tb.v"
vvp mux_ifelse
gtkwave Mux_8to1.vcd
```

### Lab 3.1(c)

```bash
iverilog -o mux_ternary "Lab_3_1(c).v" "Lab_3_1(c)_tb.v"
vvp mux_ternary
gtkwave Mux_8to1.vcd
```

### Lab 3.2

```bash
iverilog -o comparator Lab_3_2.v Lab_3_2_tb.v
vvp comparator
gtkwave comparator_rel.vcd
```

### Lab 3.3

```bash
iverilog -o decoder Lab_3_3.v Lab_3_3_tb.v
vvp decoder
gtkwave decoder_3to8.vcd
```

### Lab 3.4

```bash
iverilog -o bit_detector Lab_3_4.v Lab_3_4_tb.v
vvp bit_detector
gtkwave Lab_3_4.vcd
```

### Lab 3.5

```bash
iverilog -o parity Lab_3_5.v Lab_3_5_tb.v
vvp parity
gtkwave Parity_Gen.vcd
```

### Lab 3.6

```bash
iverilog -o mult3 Lab_3_6.v Lab_3_6_tb.v
vvp mult3
gtkwave mult3.vcd
```

### Lab 3.7

```bash
iverilog -o alu Lab_3_7.v Lab_3_7_tb.v
vvp alu
gtkwave ALU.vcd
```

---

# 🧪 Verification Approach

Each lab follows a basic **Design Under Test (DUT) + Testbench** methodology.

```text
                 ┌──────────────────┐
                 │    Testbench     │
                 │                  │
                 │ Input Stimulus   │
                 └────────┬─────────┘
                          │
                          ▼
                 ┌──────────────────┐
                 │       DUT        │
                 │                  │
                 │ Verilog Design   │
                 └────────┬─────────┘
                          │
                          ▼
                 ┌──────────────────┐
                 │      Output      │
                 │                  │
                 │ Console / VCD    │
                 └──────────────────┘
```

The testbenches use standard Verilog simulation constructs including:

* `$dumpfile`
* `$dumpvars`
* `$monitor`
* Clock generation
* Input stimulus
* `$finish`

The generated VCD files can be opened in **GTKWave** for signal-level waveform analysis.

---

# 🎯 Learning Objectives

These labs provide practical experience with:

* Verilog module and port declarations
* Combinational logic
* Sequential logic
* `always @(*)`
* `always @(posedge clk)`
* `if-else` statements
* `case` statements
* Conditional/ternary operators
* Continuous assignments
* Relational operators
* Boolean logic
* Multiplexer design
* Decoder design
* Bit counting
* Bit-position detection
* `for` loops
* Reduction operators
* Parity generation
* Shift operations
* Arithmetic operations
* Barrel shifters
* ALU design
* Non-blocking assignments
* Testbench development
* Clock generation
* VCD waveform generation
* Simulation and debugging

---

## 👨‍💻 Author

**Muhammad Hammad**

Electronic Engineering Graduate
Digital Design & Verification | Verilog | SystemVerilog | FPGA

---

## 📌 Notes

These labs are part of a progressive study of **Verilog HDL and RTL design**. Chapter 03 focuses on implementing common digital design building blocks using different Verilog coding styles and gradually introduces more complex RTL such as parity generation, arithmetic logic, bit manipulation, and a multi-operation ALU.
