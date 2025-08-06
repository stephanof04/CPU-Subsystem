module alu (
	input  [7:0] A,
	input  [7:0] B,
	input  [2:0] opcode,
	output reg [7:0] result
);
	always @(*) begin
	case (opcode)
		3'b000: result = A + B;		// Addition
		3'b001: result = A - B;		// Subtraction
		3'b010: result = A & B;		// AND
		3'b011: result = A | B;		// OR
		3'b100: result = A * B;		// Multiplication
		3'b101: result = A << 1;	// Shift left by 1
		3'b110: result = A >> 1;	// Shift right by 1	
		default: result = 8'b00000000;
	endcase
	end

endmodule

