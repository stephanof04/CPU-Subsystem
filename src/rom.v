module rom (
	input wire clk,
	input wire enable,
	input wire [4:0] address,	// from pc
	output reg [15:0] data		// instruction
);

	always @(posedge clk) begin
	if (enable) begin
	case (address)
		5'd0: data <= 16'b111_010_000_000_0101; // load r2, 5
		5'd1: data <= 16'b111_011_000_000_1000; // load r3, 8
		5'd2: data <= 16'b000_001_010_011_0000; // add r1 = r2 + r3
		5'd3: data <= 16'b001_100_011_010_0000;	// sub r4 = r3 - r2
		5'd4: data <= 16'b010_101_001_010_0000; // AND r5 = r1 & r2
		5'd5: data <= 16'b011_110_001_010_0000; // OR r6 = r1 | r2
		5'd6: data <= 16'b100_111_010_011_0000;	// Mult r7 = r2 * r3
		5'd7: data <= 16'b101_000_010_000_0000;	// Shift L r0 = r2 << 1
		5'd8: data <= 16'b110_000_011_000_0000;	// Shift R r1 = r3 >> 1

		default: data <= 16'b0000000000000000;
	endcase
	end
	end
	
endmodule
