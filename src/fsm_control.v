module fsm_control (
	input clk, // clock
	input rst, // reset
	
	//ROM
	input [15:0] instr, // 32 instructions
	output reg rom_enable,

	//PC
	// output reg [4:0] pc,
	input [4:0] pc,     // from PC module
	output reg pc_enable,

	//ALU
	output reg [2:0] alu_opcode,
	output reg [7:0] alu_A,
	output reg [7:0] alu_B,
	input [7:0] alu_result,

	//Register file
	output reg we,
	output reg [2:0] w_address,
	output reg [7:0] w_data,
	output reg [2:0] r_address1,
	output reg [2:0] r_address2,
	input [7:0] r_data1,
	input [7:0] r_data2
);

	//states
	//typedef enum logic [2:0] {FETCH, DECODE, EXECUTE, WRITEBACK, INC_PC} state_t;
	localparam 
	FETCH = 3'b000,
	DECODE = 3'b001,
	EXECUTE = 3'b010,
	WRITEBACK = 3'b011,
	INC_PC = 3'b100;
	
	reg [2:0] state, next_state;
	// reg [4:0] next_pc;

	//state_t state, next_state;

	//instructions
	//reg [2:0] opcode, rd, rs1, rs2;
	wire [2:0] opcode;
	wire [2:0] rd;
	wire [2:0] rs1;
	wire [2:0] rs2;
	wire [3:0] imm;	// new 
	assign imm = instr[3:0];

	assign opcode = instr[15:13];
	assign rd = instr[12:10];
	assign rs1 = instr[9:7];
	assign rs2 = instr[6:4];

	//fsm sequential logic
	always @(posedge clk or posedge rst) begin
	if (rst) 
	begin
		state <= FETCH;
		// pc <= 0;
	end

	else 
	begin
		state <= next_state;
		// pc <= next_pc;
	end

	end

	//fsm combinational logic
	always @(*) begin
	//set default values
	rom_enable = 0;
	we = 0;
	alu_opcode = 3'b000;
	alu_A = 8'b00000000;
	alu_B = 8'b00000000;
	w_data = 8'b00000000;
	w_address = 3'b000;
	r_address1 = 3'b000;
	r_address2 = 3'b000;
	// next_pc = pc;
	pc_enable = 0;
	next_state = FETCH;

	case (state)
	FETCH: 
	begin
		rom_enable = 1;
		next_state = DECODE;
	end
	
	DECODE: 
	begin
		r_address1 = rs1;
		r_address2 = rs2;
		next_state = EXECUTE;
	end

	EXECUTE:
	begin
		alu_opcode = opcode;
		alu_A = r_data1;
		alu_B = r_data2;
		next_state = WRITEBACK;
	end

	WRITEBACK:
	begin
		we = 1;
		w_address = rd;
		if (opcode == 3'b111)
			w_data = {4'b0000, imm};
		else
			w_data = alu_result;
		// w_data = alu_result;
		next_state = INC_PC;
	end

	INC_PC:
	begin
		// next_pc = pc + 1;
		pc_enable = 1;
		next_state = FETCH;
	end

	default:
	begin
		next_state = FETCH;
		
	end

	endcase
	end
endmodule
