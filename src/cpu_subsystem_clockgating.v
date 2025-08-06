module cpu_subsystem(
	input wire clk,
	input wire rst,
	output wire [4:0] pc_value,
	output wire [7:0] alu_out,
	output wire [15:0] instr_out,
	output wire [2:0] alu_opcode_out,
	output wire [2:0] w_address_out,
	output wire [7:0] w_data_out
);
	
	// Wiring
	// PC to ROM
	wire [4:0] pc_address;

	// ROM to FSM
	wire [15:0] instr;

	// FSM to PC
	wire pc_enable;		

	// FSM to ALU
	wire [2:0] alu_opcode;
	wire [7:0] alu_A, alu_B;
	wire [7:0] alu_result;

	// FSM to Register file
	wire we;
	wire [2:0] w_address, r_address1, r_address2;
	wire [7:0] w_data, r_data1, r_data2;

	// FSM to ROM
	wire rom_enable;

	// Clock gating
	wire gated_clk; 

	assign instr_out = instr;
	assign alu_opcode_out = alu_opcode;
	assign w_address_out = w_address;
	assign w_data_out = w_data;
	assign pc_value = pc_address;
	assign alu_out = alu_result;
	
	// Initializing PC
	pc pc_inst (
		.clk(clk),
		.rst(rst),
		.pc_enable(pc_enable),
		.pc_out(pc_address)
	);

	// Initializing ROM
	rom rom_inst (
		.clk(clk),
		.enable(rom_enable),
		.address(pc_address),
		.data(instr)
	);

	// Initializing FSM
	fsm_control fsm_control_inst (
		.clk(clk),
		.rst(rst),
		.instr(instr),
		.rom_enable(rom_enable),
		.pc(pc_address),
		.pc_enable(pc_enable),
		.alu_opcode(alu_opcode),
		.alu_A(alu_A),
		.alu_B(alu_B),
		.alu_result(alu_result),
		.we(we),
		.w_address(w_address),
		.w_data(w_data),
		.r_address1(r_address1),
		.r_address2(r_address2),
		.r_data1(r_data1),
		.r_data2(r_data2)
	);

	// Initializaing ALU
	alu alu_inst (
		.A(alu_A),
		.B(alu_B),
		.opcode(alu_opcode),
		.result(alu_result)
	);

	// Initializing Clock gating cell
	sky130_fd_sc_hd__dlclkp_1 clk_gate_inst (
		.CLK(clk),
		.GATE(we),
		.GCLK(gated_clk)
	);

	// Initializing Register file
	register_file register_file_inst (
		.clk(clk),
		.we(we),
		.w_address(w_address),
		.w_data(w_data),
		.r_address1(r_address1),
		.r_address2(r_address2),
		.r_data1(r_data1),
		.r_data2(r_data2)
	);

endmodule
