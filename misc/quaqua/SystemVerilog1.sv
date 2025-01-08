module SystemVerilog1 (
	input [10:1] a,
	input [10:1] c,
	input [10:1] b,
	input clk,
	output [10:1] d
);	
	always @(posedge clk)
		d <= 5*a**2+ 3*b+c;

endmodule
