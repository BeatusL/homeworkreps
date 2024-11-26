`timescale 1ns/1ns
module tb_lab_2s;
	parameter W = 4;
	reg clk, rst_n;
	reg [6:0] ss;
	reg [4:1] dig;
	
	always #10 clk = ~clk;
	
	lab_2s #W ss_cntr_inst (
		.clk(clk),
		.rst_n(rst_n),
		.ss(ss),
		.dig(dig)
	);
	
	
	initial begin
		clk = 0;
		rst_n = 0;
		#50 rst_n = 1;

		#1500 rst_n = 0;
		#1600 rst_n = 1;
		#2000 $stop;
	end

endmodule