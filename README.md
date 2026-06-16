# FPGA-Based Traffic Light Controller Using Verilog HDL

## Overview

This project implements an FPGA-Based Traffic Light Controller using Verilog HDL. The controller is designed as a Finite State Machine (FSM) that manages traffic signals for two directions in a safe and structured manner.

The design was verified through simulation using Icarus Verilog and waveform analysis using GTKWave.

---

## Objectives

* Design a Traffic Light Controller using Verilog HDL
* Implement Finite State Machine (FSM) based control logic
* Verify functionality through simulation
* Generate and analyze waveforms using GTKWave
* Follow FPGA-oriented digital design practices

---

## Features

* Verilog HDL implementation
* FSM-based traffic control logic
* Four traffic light states
* Automatic state transitions
* Testbench-based verification
* VCD waveform generation
* GTKWave waveform analysis
* Safe traffic sequencing

---

## Traffic Light States

The controller consists of the following states:

| State    | Road A | Road B |
| -------- | ------ | ------ |
| A_GREEN  | Green  | Red    |
| A_YELLOW | Yellow | Red    |
| B_GREEN  | Red    | Green  |
| B_YELLOW | Red    | Yellow |

State Transition Sequence:

A_GREEN → A_YELLOW → B_GREEN → B_YELLOW → A_GREEN

---

## FSM Diagram

```text
A_GREEN
    |
    v
A_YELLOW
    |
    v
B_GREEN
    |
    v
B_YELLOW
    |
    +-------> A_GREEN
```

---

## Technologies Used

* Verilog HDL
* Icarus Verilog
* GTKWave
* Digital Logic Design
* Finite State Machines (FSM)

---

## Project Structure

```text
FPGA-Traffic-Light-Controller

├── rtl
│   └── traffic_light_controller.v

├── tb
│   └── tb_traffic_light_controller.v

├── waveforms
│   └── traffic_waveform.png

├── docs

├── traffic.vcd

└── README.md
```

---

## Simulation Flow

### Compile

```bash
iverilog -o sim rtl\traffic_light_controller.v tb\tb_traffic_light_controller.v
```

### Run Simulation

```bash
vvp sim
```

### Open Waveform

```bash
gtkwave traffic.vcd
```

---

## Verification Results

The design was verified using simulation and waveform analysis.

Verified functionality:

* Correct FSM transitions
* Correct Green → Yellow → Red sequencing
* Proper alternation between Road A and Road B
* Stable reset operation
* No conflicting traffic directions observed during simulation

---

## Waveform Result


The generated waveform demonstrates successful state transitions of the traffic controller.

Waveform Screenshot:

```text
![Traffic Waveform](waveforms/traffic_waveform.png)
```

---

## Learning Outcomes

Through this project, the following concepts were explored:

* Verilog RTL Design
* Sequential Logic Design
* Finite State Machines
* Testbench Development
* Functional Verification
* Waveform Debugging
* FPGA Design Methodology

---

## Future Enhancements

Potential improvements include:

* Pedestrian Crossing Support
* Emergency Vehicle Priority
* Night Mode Operation
* Adaptive Green Timing
* Watchdog Timer
* UART-Based Monitoring
* Formal Verification

---

## Author

Jatin Gujarathi

Final Year B.Tech Student

Areas of Interest:

* VLSI Design
* FPGA Design
* Digital Logic Design
* RTL Design
* Functional Verification
