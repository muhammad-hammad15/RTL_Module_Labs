# Verilog HDL – Chapter 01 Labs

This repository contains the Verilog HDL laboratory exercises for **Chapter 01**. The labs introduce fundamental combinational and sequential digital design concepts along with basic Verilog testbench development and waveform simulation.

## 📚 Labs Overview

| Lab     | Topic                 | Design Type   | Testbench     |
| ------- | --------------------- | ------------- | ------------- |
| Lab 1.1 | Full Adder            | Combinational | `Lab1_1_tb.v` |
| Lab 1.2 | Clock Counter & Adder | Sequential    | `Lab1_2_tb.v` |
| Lab 1.3 | 2:1 Multiplexer       | Combinational | `Lab1_3_tb.v` |

---

## 🔹 Lab 1.1 – Full Adder

### Description

A **1-bit Full Adder** adds three single-bit inputs:

* `A`
* `B`
* `Cin` – Carry input

and produces:

* `Sum`
* `Cout` – Carry output

### Logic Equations

```text
Sum  = A ⊕ B ⊕ Cin

Cout = AB + BCin + ACin
```

### Files

```text
Lab1_1.v
Lab1_1_tb.v
```

### Verification

The testbench applies **all 8 possible input combinations** and displays the resulting `Sum` and `Cout`.

It also generates a VCD waveform file:

```text
full_adder.vcd
```

---

## 🔹 Lab 1.2 – Clock Counter & Adder

### Description

This lab implements a simple **sequential circuit** controlled by a clock. The design demonstrates:

* Synchronous reset
* Loading data into a counter
* Incrementing a counter
* Addition using the counter value
* Sequential logic using `always @(posedge CLK)`

### Inputs

| Signal  | Width | Description               |
| ------- | ----- | ------------------------- |
| `CLK`   | 1-bit | Clock                     |
| `RESET` | 1-bit | Synchronous reset         |
| `LOAD`  | 1-bit | Loads `DIN` into `CLKCNT` |
| `ADD`   | 1-bit | Performs addition         |
| `DIN`   | 8-bit | Input data                |

### Outputs

| Signal   | Width | Description     |
| -------- | ----- | --------------- |
| `CLKCNT` | 8-bit | Clock counter   |
| `SUM`    | 8-bit | Addition result |

### Operation

The circuit follows this priority:

```text
RESET
  ↓
LOAD
  ↓
ADD
  ↓
Increment Counter
```

When neither `RESET`, `LOAD`, nor `ADD` is active, the counter increments on every rising clock edge.

### Files

```text
Lab1_2.v
Lab1_2_tb.v
```

### Verification

The testbench verifies:

1. Reset operation
2. Normal counter operation
3. Loading a value into the counter
4. Continuing the count
5. Addition using `DIN + CLKCNT`
6. Continuing counter operation after addition

A VCD waveform file is generated:

```text
Lab1_2.vcd
```

---

## 🔹 Lab 1.3 – 2:1 Multiplexer

### Description

This lab implements a **2-to-1 Multiplexer (MUX)** using a continuous assignment.

The multiplexer selects either `A` or `B` depending on the select signal `SEL`.

### Logic

```text
SEL = 0 → Y = A
SEL = 1 → Y = B
```

The design uses the Verilog conditional operator:

```verilog
assign Y = SEL ? B : A;
```

### Inputs

| Signal | Description   |
| ------ | ------------- |
| `A`    | Input 0       |
| `B`    | Input 1       |
| `SEL`  | Select signal |

### Output

| Signal | Description     |
| ------ | --------------- |
| `Y`    | Selected output |

### Files

```text
Lab1_3.v
Lab1_3_tb.v
```

The testbench checks different combinations of `A`, `B`, and `SEL`.

A VCD waveform file is generated:

```text
mux2x1.vcd
```

---

## 📁 Repository Structure

```text
Chap_01_Labs/
│
├── Lab1_1.v
├── Lab1_1_tb.v
│
├── Lab1_2.v
├── Lab1_2_tb.v
│
├── Lab1_3.v
└── Lab1_3_tb.v
```

---

## 🛠️ Tools

These labs can be simulated using common Verilog simulators such as:

* **Icarus Verilog (iverilog)**
* **GTKWave** – for viewing VCD waveforms
* **Verilator**
* **ModelSim / Questa**
* **Vivado Simulator**

---

## ▶️ Running the Labs with Icarus Verilog

### Lab 1.1 – Full Adder

Compile:

```bash
iverilog -o full_adder_sim Lab1_1.v Lab1_1_tb.v
```

Run:

```bash
vvp full_adder_sim
```

View waveform:

```bash
gtkwave full_adder.vcd
```

---

### Lab 1.2 – Clock Counter & Adder

Compile:

```bash
iverilog -o Lab1_2_sim Lab1_2.v Lab1_2_tb.v
```

Run:

```bash
vvp Lab1_2_sim
```

View waveform:

```bash
gtkwave Lab1_2.vcd
```

---

### Lab 1.3 – 2:1 Multiplexer

Compile:

```bash
iverilog -o mux2x1_sim Lab1_3.v Lab1_3_tb.v
```

Run:

```bash
vvp mux2x1_sim
```

View waveform:

```bash
gtkwave mux2x1.vcd
```

---

## 🧪 Verification Approach

Each lab follows a basic **Design Under Test (DUT) + Testbench** structure:

```text
             ┌─────────────────┐
             │    Testbench    │
             │                 │
             │ Input Stimulus  │
             └────────┬────────┘
                      │
                      ▼
             ┌─────────────────┐
             │      DUT        │
             │                 │
             │ Verilog Design  │
             └────────┬────────┘
                      │
                      ▼
             ┌─────────────────┐
             │     Outputs     │
             │                 │
             │ Console/VCD     │
             └─────────────────┘
```

The testbenches use:

* `$display`
* `$monitor`
* `$dumpfile`
* `$dumpvars`
* Clock generation
* Input stimulus
* `$finish`

to verify the functionality of each design.

---

## 🎯 Learning Objectives

Through these labs, the following Verilog concepts are practiced:

* Verilog module structure
* Module instantiation
* Input and output ports
* `wire` and `reg`
* Continuous assignments using `assign`
* Combinational logic
* Sequential logic
* `always @(posedge CLK)`
* Synchronous reset
* Non-blocking assignments (`<=`)
* Conditional operator (`?:`)
* Testbench development
* Clock generation
* `$display` and `$monitor`
* VCD waveform generation
* Basic simulation and debugging

---

## 👨‍💻 Author

**Muhammad Hammad**

Electronic Engineering Graduate
Digital Design & Verification | Verilog | SystemVerilog | FPGA

---

## 📌 Notes

These labs are intended for learning and practicing fundamental **Verilog HDL and digital design concepts**. The testbenches are designed to demonstrate basic functional verification and waveform-based debugging.
