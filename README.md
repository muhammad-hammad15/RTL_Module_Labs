# 🚀 Verilog HDL & RTL Design Labs

<p align="center">
  <img src="https://img.shields.io/badge/Language-Verilog-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Focus-RTL%20Design-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Verification-Testbenches-green?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Waveforms-VCD-purple?style=for-the-badge" />
</p>

## 📘 About This Repository

This repository contains a progressive collection of **Verilog HDL laboratory exercises** covering fundamental digital logic, RTL coding, sequential circuits, finite-state machines, arithmetic and logic blocks, memories, and basic verification.

The labs are organized chapter-by-chapter so that the difficulty gradually increases from simple combinational circuits to more practical RTL building blocks such as **ALUs, FSMs, register files, serializers, and FIFOs**.

Each chapter has its own detailed `README.md` explaining the individual labs, design behavior, testbench operation, and simulation flow.

---

## 🗂️ Repository Overview

```text
Verilog-HDL-Labs/
│
├── Chapter_01/
│   ├── Labs...
│   └── README.md
│
├── Chapter_02/
│   ├── Labs...
│   └── README.md
│
├── Chapter_03/
│   ├── Labs...
│   └── README.md
│
├── Chapter_04/
│   ├── Labs...
│   └── README.md
│
└── README.md
```

---

## 🌱 Chapter 01 — Verilog Fundamentals

Chapter 01 introduces the basic structure of Verilog designs and testbenches.

### Topics Covered

| Lab | Design |
|---|---|
| **1.1** | 1-bit Full Adder |
| **1.2** | Clock Counter & Adder |
| **1.3** | 2:1 Multiplexer |

### Key Concepts

- Verilog module structure
- Input and output ports
- `wire` and `reg`
- Continuous assignments
- Basic combinational logic
- Clocked sequential logic
- Synchronous reset
- Non-blocking assignments
- Simple Verilog testbenches
- VCD waveform generation

> 💡 **Goal:** Build a strong foundation in Verilog syntax and basic digital circuit implementation.

---

## ⚙️ Chapter 02 — RTL Control, Loops & Data Manipulation

Chapter 02 extends the basic concepts into more structured combinational and sequential RTL.

### Topics Covered

| Lab | Design |
|---|---|
| **2.3** | 8-bit Comparator |
| **2.4** | 8-bit Register / Control Unit |
| **2.5** | Division by 3 |
| **2.6(a)** | `010` Pattern Counter |
| **2.6(b)** | Bidirectional Shift Register |
| **2.8** | 8:1 Multiplexer |

### Key Concepts

- `always @(*)`
- `always @(posedge clk)`
- `if-else`
- `case`
- `for` loops
- `while` loops
- Shift operations
- Pattern detection
- Register control
- Multiplexer design
- Iterative arithmetic

> 🔧 **Goal:** Learn how Verilog control structures can be used to describe more complex RTL behavior.

---

## 🧠 Chapter 03 — Digital Building Blocks & ALU Design

Chapter 03 focuses on implementing common digital-system components and comparing different RTL coding styles.

### Topics Covered

| Lab | Design |
|---|---|
| **3.1(a–c)** | 8:1 Multiplexer using `case`, `if-else`, and ternary operators |
| **3.2** | 8-bit Comparator |
| **3.3** | 3:8 Decoder |
| **3.4** | Bit Counter & First-1 Position Detector |
| **3.5** | 32-bit Parity Generator |
| **3.6** | Multiply-by-3 Circuit |
| **3.7** | 32-bit ALU |

### Key Concepts

- Alternative RTL coding styles
- Decoder logic
- Bit scanning
- Reduction operators
- Parity generation
- Shift-and-add arithmetic
- Logical and arithmetic operations
- Barrel shifting
- Multi-operation ALU design

> 🧩 **Goal:** Move from individual logic functions toward reusable digital hardware blocks.

---

## 🔄 Chapter 04 — Sequential Systems, FSMs & Memory

Chapter 04 moves into more advanced sequential RTL and state-based design.

### Topics Covered

| Lab | Design |
|---|---|
| **4.1** | Synchronous Set/Clear Down Counter |
| **4.2** | Up/Down Counter |
| **4.3** | Majority Detector — Moore FSM |
| **4.4** | Parallel-to-Serial Converter |
| **4.5** | Configurable Edge Detector |
| **4.6** | Sequence Detector — Mealy FSM |
| **4.7** | Parameterized Register File |
| **4.8** | Parameterized FIFO |

### Key Concepts

- Synchronous and asynchronous reset
- Control-signal priority
- Moore FSMs
- Mealy FSMs
- Serial data processing
- Edge detection
- Shift-register concepts
- Register arrays
- Read/write pointers
- FIFO `full` and `empty` logic
- Parameterized RTL design

> 🚦 **Goal:** Develop practical sequential blocks commonly used in larger RTL and verification projects.

---

## 🧪 Verification Approach

Most labs follow the same basic flow:

```text
      ┌───────────────┐
      │   Testbench   │
      │   Stimulus    │
      └───────┬───────┘
              │
              ▼
      ┌───────────────┐
      │      DUT      │
      │ Verilog RTL   │
      └───────┬───────┘
              │
              ▼
      ┌───────────────┐
      │ Console / VCD │
      │   Waveforms   │
      └───────────────┘
```

The testbenches use common Verilog simulation features such as:

- `$display`
- `$monitor`
- `$dumpfile`
- `$dumpvars`
- clock generation
- input stimulus
- reusable tasks where useful
- `$finish`

---

## 🛠️ Tools

These labs can be simulated using tools such as:

- **Icarus Verilog**
- **GTKWave**
- **ModelSim / QuestaSim**
- **Cadence Xcelium**
- **Vivado Simulator**
- **Verilator**

### Example

```bash
iverilog -o sim design.v testbench.v
vvp sim
gtkwave waveform.vcd
```

---

## 🎯 Overall Learning Path

```text
Basic Logic
    ↓
Combinational RTL
    ↓
Sequential RTL
    ↓
Counters & Registers
    ↓
Loops & Data Manipulation
    ↓
Decoders / Comparators / ALU
    ↓
Finite-State Machines
    ↓
Serialization & Edge Detection
    ↓
Register Files & FIFO
```

By completing these chapters, the repository builds practical experience in both **RTL design** and **basic functional verification** using Verilog HDL.

---

## 📚 Detailed Documentation

For detailed explanations, signal descriptions, operation tables, state-machine behavior, testbench flow, and waveform information, refer to the individual `README.md` inside each chapter.

---

## 👨‍💻 Author

**Muhammad Hammad**

Electronic Engineering Graduate  
**Digital Design & Verification | Verilog | SystemVerilog | FPGA**

---

## ⭐ Repository Purpose

This repository is intended as a structured Verilog learning and practice collection, progressing from basic digital logic toward practical RTL components used in real digital systems and verification environments.

If you find the repository useful, consider giving it a ⭐.
