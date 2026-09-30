# Chapter 4 — Verilog HDL Labs

This folder contains eight RTL design exercises written in **Verilog HDL**.  
The labs focus on core sequential-logic concepts such as counters, finite-state machines, serialization, edge detection, memories, and FIFO design.

Each lab is stored in its own directory and normally contains:

- a synthesizable Verilog design file;
- a corresponding testbench;
- waveform generation using `$dumpfile` and `$dumpvars`;
- console monitoring using `$monitor`.

---

## Repository Structure

```text
Chap_04_Labs/
├── Lab_4_1/
│   ├── Lab_4_1.v
│   └── Lab_4_1_tb.v
├── Lab_4_2/
│   ├── Lab_4_2.v
│   └── Lab_4_2_tb.v
├── Lab_4_3/
│   ├── Lab_4_3.v
│   └── Lab_4_3_tb.v
├── Lab_4_4/
│   ├── Lab_4_4.v
│   └── Lab_4_4_tb.v
├── Lab_4_5/
│   ├── Lab_4_5.v
│   └── Lab_4_5_tb.v
├── Lab_4_6/
│   ├── Lab_4_6.v
│   └── Lab_4_6_tb.v
├── Lab_4_7/
│   ├── Lab_4_7.v
│   └── Lab_4_7_tb.v
└── Lab_4_8/
    ├── Lab_4_8.v
    └── Lab_4_8_tb.v
```

---

# Lab 4.1 — Synchronous Set/Clear Down Counter

## Objective

The purpose of this lab is to implement an **8-bit synchronous sequential circuit** that can:

1. clear its output to zero;
2. load the value `16`;
3. count downward when enabled;
4. stop automatically when the count reaches zero;
5. hold its current value when counting is disabled.

The design demonstrates how multiple control signals can be prioritized inside a clocked `always` block.

## Module

```verilog
module sync_sc_ff
```

## Inputs and Outputs

| Signal | Direction | Width | Description |
|---|---|---:|---|
| `clk` | Input | 1 | Clock signal |
| `clear` | Input | 1 | Synchronously clears `out` to zero |
| `set` | Input | 1 | Synchronously loads decimal `16` |
| `en` | Input | 1 | Enables downward counting |
| `out` | Output | 8 | Current counter value |

## Operation

The circuit updates only on the **positive edge of the clock**.

The priority of the operations is:

```text
clear > set > enable/count > hold
```

Therefore:

- if `clear = 1`, `out` becomes `0`;
- else if `set = 1`, `out` becomes `16`;
- else if `en = 1` and `out > 0`, the counter decrements;
- otherwise, the current value is retained.

The condition:

```verilog
en && out > 0
```

prevents the counter from wrapping from `0` to `255`.

## Testbench

The testbench verifies:

- clearing the counter;
- setting the counter to `16`;
- counting downward;
- disabling the counter and checking that it holds;
- enabling it again;
- clearing while counting is enabled;
- confirming that the counter remains at zero instead of underflowing.

The waveform is written to:

```text
sync_sc_ff.vcd
```

---

# Lab 4.2 — 8-bit Up/Down Counter

## Objective

This lab implements an **8-bit binary up/down counter** with an **asynchronous active-high reset**.

It demonstrates:

- sequential arithmetic;
- asynchronous reset behavior;
- selecting between increment and decrement operations.

## Module

```verilog
module Counter
```

## Inputs and Outputs

| Signal | Direction | Width | Description |
|---|---|---:|---|
| `clk` | Input | 1 | Clock signal |
| `rst` | Input | 1 | Asynchronous active-high reset |
| `up_down` | Input | 1 | Selects counting direction |
| `count` | Output | 8 | Current counter value |

## Operation

The sequential block is sensitive to:

```verilog
posedge clk or posedge rst
```

This means reset does not need to wait for a clock edge.

When:

```text
rst = 1
```

the output immediately becomes:

```text
count = 0
```

When reset is inactive:

```text
up_down = 1  -> count upward
up_down = 0  -> count downward
```

Because `count` is 8 bits wide, normal binary wraparound behavior is possible:

```text
255 + 1 -> 0
0 - 1   -> 255
```

## Testbench

The testbench checks:

- asynchronous reset;
- several upward counts;
- several downward counts;
- reset activation between normal clock edges;
- resuming upward counting after reset.

The waveform is written to:

```text
Counter.vcd
```

---

# Lab 4.3 — Three-Sample Majority Detector Using a Moore FSM

## Objective

This lab implements a **finite-state machine that examines three serial input samples and determines the majority value**.

For every group of three input bits:

- if at least two bits are `1`, the output becomes `1`;
- if at least two bits are `0`, the output becomes `0`.

Examples:

```text
101 -> majority = 1
010 -> majority = 0
110 -> majority = 1
001 -> majority = 0
```

The design is implemented as a **Moore FSM**, meaning the output depends only on the current state.

## Module

```verilog
module majority_counter
```

## Inputs and Outputs

| Signal | Direction | Width | Description |
|---|---|---:|---|
| `clk` | Input | 1 | FSM clock |
| `rst` | Input | 1 | Asynchronous active-high reset |
| `in` | Input | 1 | Serial input sample |
| `out` | Output | 1 | Majority result |

## FSM States

The FSM uses eight states:

| State | Meaning |
|---|---|
| `S0` | Waiting for the first sample |
| `S1_0` | First sample was `0` |
| `S1_1` | First sample was `1` |
| `S2_00` | First two samples were `00` |
| `S2_MIX` | First two samples were `01` or `10` |
| `S2_11` | First two samples were `11` |
| `OUT_0` | Majority result is `0` |
| `OUT_1` | Majority result is `1` |

## How the FSM Works

After the first bit, the machine records whether it saw `0` or `1`.

After the second bit, there are three meaningful situations:

```text
00 -> majority is already guaranteed to be 0
11 -> majority is already guaranteed to be 1
01 or 10 -> third sample must decide the result
```

For example:

```text
S0
 |
 | in = 1
 v
S1_1
 |
 | in = 0
 v
S2_MIX
 |
 | in = 1
 v
OUT_1
```

The machine then returns to `S0` to evaluate another group of three samples.

## Why It Is a Moore FSM

The output logic is:

```verilog
if (state == OUT_1)
    out = 1'b1;
else
    out = 1'b0;
```

Therefore the input does not directly appear in the output equation.

## Testbench

The testbench verifies four representative patterns:

```text
101 -> 1
010 -> 0
110 -> 1
001 -> 0
```

The testbench also monitors the internal FSM state using:

```verilog
DUT.state
```

The waveform is written to:

```text
majority_counter.vcd
```

---

# Lab 4.4 — 8-bit Parallel-to-Serial Converter

## Objective

This lab implements an **8-bit parallel-to-serial converter**.

A complete byte is supplied through `byte_in`, and the circuit sends the byte one bit at a time through `bit_out`.

The transmission order is:

```text
MSB first
```

For example:

```text
byte_in = 10110010
```

is transmitted as:

```text
1 -> 0 -> 1 -> 1 -> 0 -> 0 -> 1 -> 0
```

## Module

```verilog
module serial
```

## Inputs and Outputs

| Signal | Direction | Width | Description |
|---|---|---:|---|
| `clk` | Input | 1 | Clock signal |
| `reset` | Input | 1 | Asynchronous active-high reset |
| `byte_in` | Input | 8 | Parallel input byte |
| `bit_out` | Output | 1 | Serial output bit |

## Internal Registers

Two registers are used:

```verilog
reg [7:0] shift_reg;
reg [2:0] count;
```

`shift_reg` stores the bits that still need to be transmitted.

`count` tracks which bit of the current byte is being sent.

## Operation

When:

```text
count = 0
```

a new byte is loaded.

The first transmitted bit is:

```verilog
byte_in[7]
```

which is the most significant bit.

The remaining seven bits are stored in `shift_reg`.

On later clock cycles:

```verilog
bit_out <= shift_reg[7];
shift_reg <= shift_reg << 1;
```

After eight transmitted bits, `count` returns to zero and a new byte can be loaded.

## Testbench

The testbench sends three bytes:

```text
10110010
11001001
11110000
```

Each byte is held for eight clock cycles so that all of its bits can be serialized.

The waveform is written to:

```text
serial.vcd
```

---

# Lab 4.5 — Configurable Edge Detector and Edge Counter

## Objective

This lab detects transitions on an input signal and counts selected edges.

The circuit can be configured to detect:

- positive edges only;
- negative edges only;
- both positive and negative edges;
- neither edge.

The lab demonstrates a common synchronous edge-detection technique: storing the previous sampled value and comparing it with the current value.

## Module

```verilog
module edge_detect
```

## Inputs and Outputs

| Signal | Direction | Width | Description |
|---|---|---:|---|
| `clk` | Input | 1 | Sampling clock |
| `rst` | Input | 1 | Asynchronous active-high reset |
| `insig` | Input | 1 | Signal whose transitions are monitored |
| `p_edge` | Input | 1 | Enable positive-edge counting |
| `n_edge` | Input | 1 | Enable negative-edge counting |
| `count` | Output | 8 | Number of detected enabled transitions |

## Previous-Sample Register

The design stores the previous sampled input in:

```verilog
reg prev_insig;
```

A positive transition occurs when:

```text
previous = 0
current  = 1
```

which is detected with:

```verilog
insig && !prev_insig
```

A negative transition occurs when:

```text
previous = 1
current  = 0
```

which is detected with:

```verilog
!insig && prev_insig
```

After the comparison, the current input is stored for use during the next clock cycle:

```verilog
prev_insig <= insig;
```

## Edge Selection

The control signals allow four operating modes:

| `p_edge` | `n_edge` | Operation |
|---:|---:|---|
| 0 | 0 | Count no transitions |
| 1 | 0 | Count positive transitions only |
| 0 | 1 | Count negative transitions only |
| 1 | 1 | Count both transition types |

## Testbench

The testbench exercises all four modes:

1. positive edges only;
2. negative edges only;
3. both edges;
4. both detectors disabled.

The counter is reset between major tests.

### Implementation Note

In the current design file the reset port is named:

```verilog
rst
```

while the current testbench connects:

```verilog
.reset(reset)
```

For named-port instantiation, those names must match. The testbench connection should therefore be changed to:

```verilog
.rst(reset)
```

or the module port can be renamed consistently.

The intended waveform file is:

```text
edge_detect.vcd
```

---

# Lab 4.6 — `0101` / `0110` Sequence Detector Using a Mealy FSM

## Objective

This lab implements a serial sequence detector that asserts its output whenever either of the following four-bit sequences is received:

```text
0101
0110
```

The detector is implemented as a **Mealy finite-state machine**.

A Mealy FSM is suitable here because the final input bit can immediately combine with the current state to determine whether a sequence has been detected.

## Module

```verilog
module seq_detect
```

## Inputs and Outputs

| Signal | Direction | Width | Description |
|---|---|---:|---|
| `clk` | Input | 1 | FSM clock |
| `rst` | Input | 1 | Synchronous active-high reset |
| `in_wire` | Input | 1 | Serial input stream |
| `out` | Output | 1 | Goes high when either target sequence is detected |

## FSM States

| State | Meaning |
|---|---|
| `IDLE` | No useful partial sequence received |
| `S0` | Received `0` |
| `S01` | Received `01` |
| `S010` | Received `010` |
| `S011` | Received `011` |

## Detecting `0101`

The state progression is:

```text
IDLE --0--> S0 --1--> S01 --0--> S010
```

If the next input is:

```text
1
```

then:

```text
0101
```

has been detected and `out` becomes `1`.

## Detecting `0110`

The state progression is:

```text
IDLE --0--> S0 --1--> S01 --1--> S011
```

If the next input is:

```text
0
```

then:

```text
0110
```

has been detected and `out` becomes `1`.

## Why It Is a Mealy FSM

The output depends on both:

- the current state;
- the current input bit.

The detection equation is:

```verilog
(state == S010 && in_wire == 1'b1) ||
(state == S011 && in_wire == 1'b0)
```

Therefore the output can react immediately to the final sequence bit without requiring a separate output state.

## Reset Behavior

The state register uses:

```verilog
always @(posedge clk)
```

and checks `rst` inside the block.

Therefore reset is **synchronous**: it takes effect on the next positive clock edge.

## Testbench

A reusable task sends one input bit at a time:

```verilog
task send_bit;
```

The testbench changes `in_wire` on the **negative edge** of the clock. This ensures the signal is already stable before the FSM samples it at the following positive edge.

The test stream includes:

```text
0101
0110
0101
```

with additional nonmatching bits between some sequences.

The waveform is written to:

```text
seq_detect.vcd
```

---

# Lab 4.7 — Parameterized Register File

## Objective

This lab implements a small memory structure using a Verilog register array.

The design supports:

- synchronous write operations;
- combinational read operations;
- configurable data width and memory depth.

This introduces the basic structure used in register files and simple on-chip memories.

## Module

```verilog
module regfile
```

The default parameters are:

```verilog
Width = 8
Depth = 16
```

Therefore the default configuration contains:

```text
16 registers x 8 bits
```

## Inputs and Outputs

| Signal | Direction | Width | Description |
|---|---|---:|---|
| `clk` | Input | 1 | Write clock |
| `r_w` | Input | 1 | Read/write control |
| `addr_in` | Input | 4 | Register address |
| `d_in` | Input | `Width` | Data to write |
| `d_out` | Output | `Width` | Data read from memory |

## Memory Declaration

The memory is declared as:

```verilog
reg [Width-1:0] mem [0:Depth-1];
```

With the default parameters this creates sixteen 8-bit storage locations.

## Write Operation

Writing is synchronous.

When:

```text
r_w = 1
```

the value on `d_in` is stored at `addr_in` on the positive clock edge:

```verilog
mem[addr_in] <= d_in;
```

## Read Operation

Reading is combinational.

When:

```text
r_w = 0
```

the selected memory value immediately appears at `d_out`.

When the circuit is in write mode, `d_out` is forced to zero:

```verilog
assign d_out = (!r_w) ? mem[addr_in] : {Width{1'b0}};
```

## Testbench

The testbench first writes:

```text
Address 3  <- 25
Address 7  <- 50
Address 12 <- 100
```

It then switches to read mode and checks the same locations.

Expected values are:

```text
Address 3  -> 25
Address 7  -> 50
Address 12 -> 100
```

The waveform is written to:

```text
regfile.vcd
```

---

# Lab 4.8 — Parameterized FIFO

## Objective

This lab implements a **First-In, First-Out (FIFO) memory buffer**.

A FIFO preserves the order in which data is received:

```text
first value written -> first value read
```

The design supports:

- data writes;
- data reads;
- separate read and write pointers;
- empty detection;
- full detection;
- simultaneous read and write operations.

## Module

```verilog
module fifo
```

Default parameters:

```verilog
Width = 8
Depth = 128
```

So the default FIFO can store:

```text
128 entries x 8 bits
```

## Inputs and Outputs

| Signal | Direction | Width | Description |
|---|---|---:|---|
| `clk` | Input | 1 | FIFO clock |
| `reset` | Input | 1 | Asynchronous active-high reset |
| `d_in` | Input | `Width` | Input data |
| `d_in_valid` | Input | 1 | Requests a write |
| `d_out_req` | Input | 1 | Requests a read |
| `d_out` | Output | `Width` | Data removed from FIFO |
| `empty` | Output | 1 | FIFO contains no entries |
| `full` | Output | 1 | FIFO contains `Depth` entries |

## Internal Storage

The FIFO memory is:

```verilog
reg [Width-1:0] mem [0:Depth-1];
```

Two pointers identify the next write and read locations:

```verilog
wr_ptr
rd_ptr
```

A separate counter tracks the number of stored entries:

```verilog
count
```

## Write Operation

A write occurs when:

```text
d_in_valid = 1
and
full = 0
```

The incoming value is stored at:

```verilog
mem[wr_ptr]
```

and the write pointer advances.

## Read Operation

A read occurs when:

```text
d_out_req = 1
and
empty = 0
```

The value at:

```verilog
mem[rd_ptr]
```

is transferred to `d_out`, and the read pointer advances.

## FIFO Count Management

The design evaluates whether a valid read and/or write occurred.

```text
write only -> count + 1
read only  -> count - 1
read/write -> count unchanged
nothing    -> count unchanged
```

This is implemented with:

```verilog
case ({write_condition, read_condition})
```

A simultaneous read and write are therefore supported without incorrectly changing the number of stored entries.

## Empty and Full Flags

The FIFO is empty when:

```verilog
count == 0
```

and full when:

```verilog
count == Depth
```

## Testbench

The testbench checks:

1. FIFO reset;
2. writing several values;
3. reading values back in FIFO order;
4. empty behavior after all values are removed;
5. writing new values;
6. simultaneous read and write;
7. continued reading after the simultaneous operation.

The intended sequence demonstrates that data should leave the FIFO in the same order in which it entered.

### 8-bit Data-Width Note

The default input width is 8 bits, so the largest unsigned value that can be represented is:

```text
255
```

The current testbench includes:

```verilog
d_in = 8'd300;
```

`300` cannot be represented by 8 bits and will be truncated to its lower 8 bits.

For an 8-bit testbench, use a value from:

```text
0 to 255
```

or increase the FIFO `Width` parameter if values larger than `255` are required.

The waveform is written to:

```text
fifo.vcd
```

---

# Running the Labs

These files can be simulated using any Verilog-compatible simulator.

Examples include:

- Icarus Verilog;
- ModelSim / QuestaSim;
- Xcelium;
- Vivado Simulator;
- Verilator, where appropriate.

## Example Using Icarus Verilog

To simulate Lab 4.6:

```bash
cd Lab_4_6

iverilog -o sim Lab_4_6.v Lab_4_6_tb.v
vvp sim
```

If GTKWave is installed:

```bash
gtkwave seq_detect.vcd
```

The same basic procedure can be used for the remaining labs by changing the design and testbench filenames.

---

# Main Concepts Covered

These labs collectively practice:

- clocked sequential logic;
- nonblocking assignments;
- synchronous reset;
- asynchronous reset;
- counters;
- control-signal priority;
- finite-state machines;
- Moore FSMs;
- Mealy FSMs;
- serial data processing;
- parallel-to-serial conversion;
- transition detection;
- previous-state sampling;
- Verilog memory arrays;
- synchronous writes;
- combinational reads;
- read/write pointers;
- FIFO full and empty detection;
- parameterized RTL modules;
- testbench stimulus generation;
- reusable testbench tasks;
- hierarchical signal monitoring;
- VCD waveform generation.

---

# Summary

| Lab | Design | Main Concept |
|---|---|---|
| **4.1** | Set/Clear Down Counter | Sequential control priority |
| **4.2** | Up/Down Counter | Asynchronous reset and arithmetic |
| **4.3** | Majority Detector | Moore FSM |
| **4.4** | Parallel-to-Serial Converter | Shift-register-based serialization |
| **4.5** | Edge Detector | Previous-sample transition detection |
| **4.6** | Sequence Detector | Mealy FSM |
| **4.7** | Register File | Memory array and read/write control |
| **4.8** | FIFO | Queues, pointers, count, full/empty flags |

These exercises progress from relatively simple clocked circuits toward more complete RTL building blocks and provide practical experience with both **design** and **verification** in Verilog HDL.
