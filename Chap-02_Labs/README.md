# Verilog HDL – Chapter 02 Labs

This repository contains the **Chapter 02 Verilog HDL laboratory exercises**, focusing on combinational logic, sequential logic, iterative operations, pattern detection, shift registers, and multiplexers.

The labs provide hands-on practice with `always` blocks, conditional statements, `case` statements, loops, sequential logic, shift operations, and Verilog testbench development.

---

## 📚 Labs Overview

| Lab     | Topic                         | Design Type   | Main Concepts                                   |
| ------- | ----------------------------- | ------------- | ----------------------------------------------- |
| Lab 2.3 | 8-bit Comparator              | Combinational | `if-else`, comparison operators                 |
| Lab 2.4 | 8-bit Register / Control Unit | Sequential    | `case`, clocked logic, load/increment/decrement |
| Lab 2.5 | Division by 3                 | Combinational | `while` loop, iterative subtraction             |
| Lab 2.6 | Pattern Counter               | Combinational | `for` loop, pattern detection                   |
| Lab 2.7 | 8-bit Shift Register          | Sequential    | Load, shift left, shift right                   |
| Lab 2.8 | 8:1 Multiplexer               | Combinational | Nested ternary operators                        |

---

# 🔹 Lab 2.3 – 8-bit Comparator

### Description

This lab implements an **8-bit magnitude comparator** that compares two unsigned 8-bit inputs, `a` and `b`.

The circuit determines whether:

* `a > b`
* `a < b`
* `a == b`

### Inputs

| Signal | Width | Description  |
| ------ | ----- | ------------ |
| `a`    | 8-bit | First input  |
| `b`    | 8-bit | Second input |

### Outputs

| Signal | Description       |
| ------ | ----------------- |
| `g`    | `1` when `a > b`  |
| `l`    | `1` when `a < b`  |
| `e`    | `1` when `a == b` |

### Logic

```text
a > b  → g = 1, l = 0, e = 0
a < b  → g = 0, l = 1, e = 0
a == b → g = 0, l = 0, e = 1
```

The design uses a combinational:

```verilog
always @(*)
```

block with `if-else` statements.

### Files

```text
Lab2_3.v
Lab2_3_tb.v
```

### Verification

The testbench verifies:

1. `a > b`
2. `a < b`
3. `a == b`
4. Unknown (`X`) input behavior

A VCD waveform is generated:

```text
Control_Lab.vcd
```

---

# 🔹 Lab 2.4 – 8-bit Register with Control Operations

### Description

This lab implements an **8-bit sequential register** whose operation is controlled by a 2-bit control signal `c`.

The circuit operates on the rising edge of the clock.

### Control Table

| `c`  | Operation           |
| ---- | ------------------- |
| `00` | Load `din`          |
| `01` | Increment `dout`    |
| `10` | Decrement `dout`    |
| `11` | Reset `dout` to `0` |

### Inputs

| Signal | Width | Description    |
| ------ | ----- | -------------- |
| `clk`  | 1-bit | Clock          |
| `c`    | 2-bit | Control signal |
| `din`  | 8-bit | Input data     |

### Output

| Signal | Width | Description     |
| ------ | ----- | --------------- |
| `dout` | 8-bit | Register output |

### Sequential Logic

The circuit uses:

```verilog
always @(posedge clk)
```

and a `case` statement to determine the operation performed at every positive clock edge.

### Files

```text
Lab_2_4.v
Lab_2_4_tb.v
```

### Verification

The testbench verifies:

* Reset
* Loading data
* Incrementing
* Decrementing
* Loading a new value
* Resetting the register

A VCD waveform is generated:

```text
Lab_2_4.vcd
```

---

# 🔹 Lab 2.5 – Division by 3 Using Iterative Subtraction

### Description

This lab demonstrates how division can be implemented using **repeated subtraction**.

The input value `din` is divided by `3`. The circuit repeatedly subtracts `3` until the remaining value is less than `3`.

The results are:

* `result` → quotient
* `remainder` → remainder

### Example

For:

```text
din = 10
```

The operation is:

```text
10 - 3 = 7
7  - 3 = 4
4  - 3 = 1
```

Therefore:

```text
10 / 3 = 3 remainder 1
```

### Inputs

| Signal | Width  | Description |
| ------ | ------ | ----------- |
| `din`  | 16-bit | Input value |

### Outputs

| Signal      | Width  | Description |
| ----------- | ------ | ----------- |
| `result`    | 15-bit | Quotient    |
| `remainder` | 2-bit  | Remainder   |

### Main Concept

The design uses a `while` loop:

```verilog
while (i >= 3)
```

Each iteration subtracts `3` and increments the quotient.

### Files

```text
Lab_2_5.v
Lab_2_5_tb.v
```

### Verification

The testbench checks several values including:

```text
3
4
10
15
20
100
255
```

A VCD waveform is generated:

```text
Lab_2_5.vcd
```

---

# 🔹 Lab 2.6 – 010 Pattern Counter

### Description

This lab implements a **pattern detector** that counts the number of occurrences of the 3-bit sequence:

```text
010
```

within a 32-bit input.

The design scans the input using a `for` loop and checks three consecutive bits at a time.

### Example

For:

```text
din = ...01010
```

the pattern `010` occurs twice because overlapping patterns are also detected.

```text
01010
^^^
  ^^^
```

### Inputs

| Signal | Width  | Description |
| ------ | ------ | ----------- |
| `din`  | 32-bit | Input data  |

### Output

| Signal  | Width | Description              |
| ------- | ----- | ------------------------ |
| `count` | 4-bit | Number of `010` patterns |

### Main Concept

The design checks:

```verilog
{din[i], din[i+1], din[i+2]} == 3'b010
```

for each valid position in the 32-bit input.

### Files

```text
Lab_2_6.v
Lab_2_6_tb.v
```

### Verification

The testbench verifies:

* No pattern
* One occurrence
* Overlapping occurrences
* Multiple occurrences
* Mixed input patterns

A VCD waveform is generated:

```text
Lab_2_6.vcd
```

---

# 🔹 Lab 2.7 – 8-bit Shift Register

### Description

This lab implements an **8-bit bidirectional shift register** with support for:

* Parallel load
* Shift left
* Shift right
* Hold previous value

The operations are performed on the rising edge of the clock.

### Control Signals

| Signal | Function                      |
| ------ | ----------------------------- |
| `Load` | Loads `din` into the register |
| `SHL`  | Shifts data left by one bit   |
| `SHR`  | Shifts data right by one bit  |
| None   | Holds the current value       |

### Inputs

| Signal | Width | Description         |
| ------ | ----- | ------------------- |
| `CLK`  | 1-bit | Clock               |
| `SHL`  | 1-bit | Shift-left control  |
| `SHR`  | 1-bit | Shift-right control |
| `Load` | 1-bit | Load control        |
| `din`  | 8-bit | Parallel input      |

### Output

| Signal | Width | Description           |
| ------ | ----- | --------------------- |
| `dout` | 8-bit | Shift register output |

### Operation Priority

The control logic follows:

```text
Load
  ↓
Shift Left
  ↓
Shift Right
  ↓
Hold
```

The design uses:

```verilog
always @(posedge CLK)
```

with non-blocking assignments.

### Example

If:

```text
dout = 10110010
```

A left shift produces:

```text
01100100
```

A right shift produces:

```text
01011001
```

### Files

```text
Lab_2_7.v
Lab_2_7_tb.v
Lab_2_7_Description.txt
```

### Verification

The testbench verifies:

1. Loading a value
2. Holding the value
3. Shifting left
4. Shifting right
5. Loading a new value

A VCD waveform is generated:

```text
Shifter_8_bit.vcd
```

---

# 🔹 Lab 2.8 – 8:1 Multiplexer

### Description

This lab implements an **8-to-1 multiplexer** using nested ternary operators.

The 3-bit select signal determines which of the eight input signals is connected to the output.

### Inputs

```text
d0
d1
d2
d3
d4
d5
d6
d7
```

### Select Table

| `sel` | Output |
| ----- | ------ |
| `000` | `d0`   |
| `001` | `d1`   |
| `010` | `d2`   |
| `011` | `d3`   |
| `100` | `d4`   |
| `101` | `d5`   |
| `110` | `d6`   |
| `111` | `d7`   |

### Main Concept

The multiplexer is implemented using nested conditional operators:

```verilog
assign out = (sel == 3'd0) ? d0 :
             (sel == 3'd1) ? d1 :
             ...
             d7;
```

### Files

```text
Lab_2_8.v
Lab_2_8_tb.v
```

### Verification

The testbench assigns different values to all eight inputs and changes `sel` from `0` to `7` to verify every possible selection.

A VCD waveform is generated:

```text
mux8x1.vcd
```

---

# 📁 Repository Structure

```text
Chap-02_Labs/
│
├── Lab2_3.v
├── Lab2_3_tb.v
│
├── Lab_2_4.v
├── Lab_2_4_tb.v
│
├── Lab_2_5.v
├── Lab_2_5_tb.v
│
├── Lab_2_6.v
├── Lab_2_6_tb.v
│
├── Lab_2_7.v
├── Lab_2_7_tb.v
├── Lab_2_7_Description.txt
│
├── Lab_2_8.v
└── Lab_2_8_tb.v
```

---

# 🛠️ Tools

These labs can be simulated using:

* **Icarus Verilog**
* **GTKWave**
* **ModelSim / Questa**
* **Vivado Simulator**
* **Verilator**

---

# ▶️ Running the Labs with Icarus Verilog

## Lab 2.3

```bash
iverilog -o Lab2_3_sim Lab2_3.v Lab2_3_tb.v
vvp Lab2_3_sim
gtkwave Control_Lab.vcd
```

## Lab 2.4

```bash
iverilog -o Lab2_4_sim Lab_2_4.v Lab_2_4_tb.v
vvp Lab2_4_sim
gtkwave Lab_2_4.vcd
```

## Lab 2.5

```bash
iverilog -o Lab2_5_sim Lab_2_5.v Lab_2_5_tb.v
vvp Lab2_5_sim
gtkwave Lab_2_5.vcd
```

## Lab 2.6

```bash
iverilog -o Lab2_6_sim Lab_2_6.v Lab_2_6_tb.v
vvp Lab2_6_sim
gtkwave Lab_2_6.vcd
```

## Lab 2.7

```bash
iverilog -o Lab2_7_sim Lab_2_7.v Lab_2_7_tb.v
vvp Lab2_7_sim
gtkwave Shifter_8_bit.vcd
```

## Lab 2.8

```bash
iverilog -o Lab2_8_sim Lab_2_8.v Lab_2_8_tb.v
vvp Lab2_8_sim
gtkwave mux8x1.vcd
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

The testbenches make use of:

* `$display`
* `$monitor`
* `$dumpfile`
* `$dumpvars`
* Clock generation
* Input stimulus
* `$finish`

to verify the functionality of the designs.

---

# 🎯 Learning Objectives

These labs provide practical experience with:

* Verilog module and port declarations
* Combinational `always @(*)` blocks
* Sequential `always @(posedge clk)` blocks
* `if-else` statements
* `case` statements
* Comparison operators
* Ternary operators
* `for` loops
* `while` loops
* Shift operators
* Non-blocking assignments (`<=`)
* Continuous assignments (`assign`)
* Registers and combinational logic
* Pattern detection
* Multiplexer implementation
* Shift-register design
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

These labs are part of a progressive study of **Verilog HDL and digital design**. The exercises move from basic combinational logic to sequential circuits and introduce important RTL constructs such as loops, `case` statements, conditional operators, and clocked logic.

The accompanying testbenches are included to demonstrate basic functional verification and waveform-based debugging.