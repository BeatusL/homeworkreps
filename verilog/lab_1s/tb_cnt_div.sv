`timescale 1 ns/1 ns
module tb_cnt_div();

	localparam CLK_PERIOD = 20;
	reg clk;
	reg rst_n;
	wire ena;
	integer i;
	
	localparam parametr = 4;
	
	cnt_div #parametr cnt_div (
		.clk(clk),
		.rst_n(rst_n),
		.ena(ena)
	);
	
	initial begin: clk_generation
		clk = 1'b0;
		forever #(CLK_PERIOD/2) clk = ~clk;
	end
	
	initial #1000 $stop;

endmodule
