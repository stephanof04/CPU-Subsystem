# CPU Subsystem — Constraints (matches config.tcl: clk @ 20.0 ns)
# Single clock domain on 'clk'; async active-low reset 'rst_n' (edit if different)

# 1) Primary clock: 50 MHz (20 ns period)
create_clock -name core_clk -period 20.000 [get_ports clk]

# Small margin for jitter/skew
set_clock_uncertainty 0.05 [get_clocks core_clk]

# 2) Don't time asynchronous reset (remove if synchronous)
set_false_path -from [get_ports rst_n]

# 3) Generic I/O timing (documentary placeholders; safe if you don't re-run)
set_input_delay  0.20 -clock core_clk \
  [remove_from_collection [all_inputs] [list [get_ports clk] [get_ports rst_n]]]
set_output_delay 0.20 -clock core_clk [all_outputs]

# 4) Optional I/O electrical assumptions
# set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin Y \
#   [remove_from_collection [all_inputs] [list [get_ports clk] [get_ports rst_n]]]
# set_load 0.10 [all_outputs]
