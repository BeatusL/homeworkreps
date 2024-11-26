`timescale 1ns/1ns
module tb_lab_1s();
	localparam CLK_PERIOD = 10;
	reg clk;
	reg rst_n = 1;
	wire [7:0] dout;
	
	localparam parametr = 4;
	
	lab_1s #parametr lab_1s (
		.clk(clk),
		.rst_n(rst_n),
		.dout(dout)
	);
	
	initial begin: clk_generation
		clk = 1'b0;
		forever #(CLK_PERIOD/2) clk = ~clk;
	end
	
	initial #1500 rst_n = 0;
	initial #1600 rst_n = 1;
	
	initial #2000 $stop;

endmodule
