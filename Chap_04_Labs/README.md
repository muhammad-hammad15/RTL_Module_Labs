# Verilog HDL – Chapter 04 Labs

This folder contains the **Chapter 04 Verilog HDL laboratory exercises**. The chapter focuses mainly on **sequential RTL design**, finite-state machines, serial data processing, edge detection, register files, and FIFO memory.

Each lab contains the Verilog RTL design together with a testbench for functional verification and waveform analysis.

---

## 📚 Labs Overview

| Lab | Topic | Design Type | Main Concepts |
|---|---|---|---|
| **Lab 4.1** | Synchronous Set/Clear Counter | Sequential | Counter, enable, set, clear |
| **Lab 4.2** | Up/Down Counter | Sequential | Increment, decrement, asynchronous reset |
| **Lab 4.3** | Majority Detector | FSM | Moore FSM, state transitions |
| **Lab 4.4** | Parallel-to-Serial Converter | Sequential | Shift register, serialization |
| **Lab 4.5** | Edge Detector | Sequential | Rising/falling edge detection |
| **Lab 4.6** | Sequence Detector | FSM | Mealy FSM, `0101` / `0110` detection |
| **Lab 4.7** | Register File | Memory | Register array, synchronous write |
| **Lab 4.8** | FIFO | Memory | Read/write pointers, full/empty control |

---

# 🔹 Lab 4.1 – Synchronous Set/Clear Counter

Implements an **8-bit counter** with synchronous control signals.

The counter can:

- clear its value to `0`;
- load the value `16`;
- count downward when enabled;
- hold its value when disabled;
- stop counting after reaching zero.

The control priority is:

```text
Clear
  ↓
Set
  ↓
Enable / Count
  ↓
Hold
```

### Main Concepts

- Clocked sequential logic
- Control priority
- Non-blocking assignments
- Counter design

---

# 🔹 Lab 4.2 – Up/Down Counter

Implements an **8-bit up/down counter**.

The `up_down` control determines the counting direction:

```text
up_down = 1 → Count Up
up_down = 0 → Count Down
```

The design also uses an **asynchronous active-high reset**.

### Main Concepts

- Up/down counting
- Asynchronous reset
- Sequential arithmetic
- `always @(posedge clk or posedge rst)`

---

# 🔹 Lab 4.3 – Majority Detector using Moore FSM

This lab implements a finite-state machine that examines **three serial input bits** and determines their majority value.

For example:

```text
101 → Majority = 1
110 → Majority = 1
010 → Majority = 0
001 → Majority = 0
```

The design uses a **Moore FSM**, meaning the output depends only on the current state.

### Main Concepts

- Finite-State Machines
- Moore FSM
- State register
- Next-state logic
- Output logic

---

# 🔹 Lab 4.4 – Parallel-to-Serial Converter

Implements an **8-bit parallel-to-serial converter**.

A complete 8-bit value is loaded in parallel and transmitted one bit at a time.

Example:

```text
Parallel Input

10110010

      ↓

Serial Output

1 → 0 → 1 → 1 → 0 → 0 → 1 → 0
```

The transmission is performed **MSB first**.

### Main Concepts

- Shift registers
- Serial communication
- Counters
- Parallel-to-serial conversion

---

# 🔹 Lab 4.5 – Configurable Edge Detector

This lab detects changes in an input signal.

The circuit can be configured to detect:

- positive edges;
- negative edges;
- both positive and negative edges;
- no edges.

A previous copy of the input is stored and compared with the current input.

```text
0 → 1 = Positive Edge

1 → 0 = Negative Edge
```

Each detected edge increments a counter.

### Main Concepts

- Edge detection
- Previous-state storage
- Signal transition detection
- Sequential counters

---

# 🔹 Lab 4.6 – Sequence Detector using Mealy FSM

This lab implements a serial sequence detector for:

```text
0101
0110
```

The FSM keeps track of previously received bits and asserts `out` when either sequence is detected.

Example state progression:

```text
IDLE → S0 → S01 → S010 → 0101 Detected
```

or:

```text
IDLE → S0 → S01 → S011 → 0110 Detected
```

The design uses a **Mealy FSM**, meaning the output depends on both:

```text
Current State + Current Input
```

### Main Concepts

- Mealy FSM
- Sequence detection
- State transitions
- Serial bit processing

---

# 🔹 Lab 4.7 – Parameterized Register File

Implements a small **register-file memory**.

The default configuration is:

```text
16 Registers × 8 Bits
```

The design provides:

- synchronous write operation;
- combinational read operation;
- configurable data width;
- configurable memory depth.

Memory is implemented using a Verilog register array:

```verilog
reg [Width-1:0] mem [0:Depth-1];
```

### Main Concepts

- Verilog memory arrays
- Parameterized modules
- Addressing
- Synchronous write
- Combinational read

---

# 🔹 Lab 4.8 – Parameterized FIFO

Implements a **First-In, First-Out (FIFO)** memory buffer.

Data is removed in the same order in which it was written:

```text
Write:

10 → 20 → 30

Read:

10 → 20 → 30
```

The FIFO uses:

- memory array;
- write pointer;
- read pointer;
- entry counter;
- `full` flag;
- `empty` flag.

It also supports simultaneous read and write operations.

### Main Concepts

- FIFO architecture
- Read/write pointers
- Memory arrays
- Full/empty detection
- Simultaneous read/write
- Parameterized RTL

---

## 📁 Folder Structure

```text
Chap_04_Labs/
│
├── Lab_4_1/
│   ├── Lab_4_1.v
│   └── Lab_4_1_tb.v
│
├── Lab_4_2/
│   ├── Lab_4_2.v
│   └── Lab_4_2_tb.v
│
├── Lab_4_3/
│   ├── Lab_4_3.v
│   └── Lab_4_3_tb.v
│
├── Lab_4_4/
│   ├── Lab_4_4.v
│   └── Lab_4_4_tb.v
│
├── Lab_4_5/
│   ├── Lab_4_5.v
│   └── Lab_4_5_tb.v
│
├── Lab_4_6/
│   ├── Lab_4_6.v
│   └── Lab_4_6_tb.v
│
├── Lab_4_7/
│   ├── Lab_4_7.v
│   └── Lab_4_7_tb.v
│
└── Lab_4_8/
    ├── Lab_4_8.v
    └── Lab_4_8_tb.v
```

---

## 🧪 Verification Approach

Each lab follows a basic RTL verification structure:

```text
        ┌───────────────┐
        │   Testbench   │
        │   Stimulus    │
        └───────┬───────┘
                │
                ▼
        ┌───────────────┐
        │      DUT      │
        │  Verilog RTL  │
        └───────┬───────┘
                │
                ▼
        ┌───────────────┐
        │    Results    │
        │ Console / VCD │
        └───────────────┘
```

The testbenches use common simulation constructs such as:

- `$monitor`
- `$display`
- `$dumpfile`
- `$dumpvars`
- clock generation
- input stimulus
- `$finish`

---

## 🛠️ Simulation Tools

The labs can be simulated using:

- **Icarus Verilog**
- **GTKWave**
- **ModelSim / QuestaSim**
- **Cadence Xcelium**
- **Vivado Simulator**
- **Verilator**

Example using Icarus Verilog:

```bash
iverilog -o sim Lab_4_6.v Lab_4_6_tb.v
vvp sim
```

To view the waveform:

```bash
gtkwave seq_detect.vcd
```

---

## 🎯 Learning Objectives

Chapter 04 provides practical experience with:

- Sequential RTL design
- Synchronous and asynchronous resets
- Counters
- Moore FSMs
- Mealy FSMs
- State transition logic
- Sequence detection
- Edge detection
- Shift registers
- Serial data processing
- Verilog memory arrays
- Register files
- FIFO architecture
- Parameterized RTL modules
- Verilog testbench development
- VCD waveform analysis

---

## 👨‍💻 Author

**Muhammad Hammad**

Electronic Engineering Graduate  
**Digital Design & Verification | Verilog | SystemVerilog | FPGA**

---

## 📌 Notes

Chapter 04 moves from basic sequential circuits toward more practical RTL building blocks. The labs introduce **FSM-based control, serial processing, register-based memories, and FIFO architecture**, providing a useful foundation for more advanced **SystemVerilog and UVM verification** work.