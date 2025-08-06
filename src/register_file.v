module register_file (
	input wire clk,	//clock
	input wire we,	//write enable
	input wire [2:0] w_address,	//write address
	input wire [7:0] w_data,	//data to write
	
	input wire [2:0] r_address1,	//read address 1
	input wire [2:0] r_address2,	//read address 2

	output wire [7:0] r_data1,	//data 1 output
	output wire [7:0] r_data2	//data 2 ouput
);

	reg [7:0] registers[7:0];

	//synchronous write
	always @(posedge clk) begin
	if (we)
		registers[w_address] <= w_data;
	end

	//asynchrnous read
	assign r_data1 = registers[r_address1];
	assign r_data2 = registers[r_address2];

endmodule

