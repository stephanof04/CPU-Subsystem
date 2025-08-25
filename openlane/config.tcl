set ::env(DESIGN_NAME) cpu_subsystem
set ::env(TOP_MODULE) "cpu_subsystem"

set ::env(VERILOG_FILES) [list \
    $::env(DESIGN_DIR)/src/alu.v \
    $::env(DESIGN_DIR)/src/register_file.v \
    $::env(DESIGN_DIR)/src/pc.v \
    $::env(DESIGN_DIR)/src/rom.v \
    $::env(DESIGN_DIR)/src/fsm_control.v \
    $::env(DESIGN_DIR)/src/cpu_subsystem.v \
]

set ::env(FP_PIN_ORDER_CFG) "$::env(DESIGN_DIR)/pin_order.cfg"
set ::env(SDC_FILE) "$::env(DESIGN_DIR)/constraints.sdc"

set ::env(PL_SKIP_INITIAL_PLACEMENT) 0
set ::env(PL_RANDOM_IO_PLACEMENT) 0

set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) 20.0

#Optimizations
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(GLB_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_BUFFER_INPUT_PORTS) 1
set ::env(GLB_RESIZER_BUFFER_INPUT_PORTS) 1

#Floorplan
set ::env(FP_SIZING) "relative"
set ::env(FP_CORE_UTIL) 50
set ::env(DIE_ASPECT_RATIO) 1.0

#Timing
set ::env(PL_RESIZER_ENABLE) 1
set ::env(GLB_RESIZER_HOLD_SLACK_MARGIN) 0.2
set ::env(CTS_MAX_FANOUT) 10
