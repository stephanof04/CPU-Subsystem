# CPU-Subsystem (RTL > GDSII on Sky130)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A small CPU Subsystem (ALU, FSM, Register File, Program Counter, ROM) designed in Verilog and implemented using OpenLane on the SkyWater 130nm PDK.
This project demonstrates a complete ASIC flow - from RTL design through synthesis, floorplanning, placement, clock tree synthesis (CTS), routing, and signoff (STA, DRC, LVS).

## Key Results
| Metric                | Result             |
|-----------------------|--------------------|
| Core area reduction   | **−33.8%**         |
| Die area reduction    | **−15.8%**         |
| Utilization           | ~50%               |
| Timing (STA)          | +69% hold slack improvement, **0.04 ns** skew |
| Power                 | **−32%** total dynamic, incl. **−88%** combinational logic power |

* Achieved clean routing, CTS closure, and reproducible results.
* Automated optimization flows with **TCL scripting**.
* Demonstrates **pin placement control** (custom JSON) and power-aware design with **clock gating**.

## Architecture
Modules: ALU, FSM Control, Register File, Program Counter, ROM
Top-level: cpu_subsystem.v
Single clock domain (`clk` @ 20 ns = 50 MHz), async reset (`rst_n`)
FSM controls instruction sequencing, interacting with the register file and ALU for a single compute flow.

See [`/src/`](src) for RTL modules.

## Reports and Layouts
- Layout screenshots (KLayout/Magic) in [`/images`](images)  
- Reports (area, power, STA, CTS) in [`/reports`](reports)  
- Pin placement config in [`/openlane/pin_order.cfg`](openlane/pin_order.cfg)  
- Example included [`constraints.sdc`](openlane/constraints.sdc) (documentary; original results used OpenLane auto-SDC)

Screenshots include:
- Final routed layout
- Congestion heatmap
- Pin placement visualization
- Power and STA report snippets

## How to Reproduce
This project was implemented using [OpenLane](https://github.com/The-OpenROAD-Project/OpenLane) with the [SkyWater 130nm PDK](https://github.com/google/skywater-pdk).  
You must have OpenLane + the PDK installed separately (not included in this repo).
Only /src + /openlane configs are needed, /reports + /images are artifacts.

To reproduce the flow:
1. Install OpenLane with Sky130 PDK (see [OpenLane installation guide](https://github.com/The-OpenROAD-Project/OpenLane)).  
2. Clone this repo:
   ```bash
   git clone https://github.com/stephanof04/CPU-Subsystem
   cd CPU-Subsystem/openlane
   ./flow.tcl -design
