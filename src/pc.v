module pc (
	input wire clk,
	input wire rst,
	input wire pc_enable,	// enables signal from fsm
	output reg[4:0] pc_out	// 5 bit program counter
);

	always @(posedge clk) begin
	if (rst)
		pc_out <= 5'b00000;	// reset to 0
	else if (pc_enable)
		pc_out <= pc_out + 1;	// increment
	else
		pc_out <= pc_out;	// hold
	end
endmodule
