`timescale 1ns/1ns
module tb_lab_c1 ;
	logic clk, dir, reset;
	reg [3:0] cntQ;
	
	lab_c1 inst (
		.clk(clk), .dir(dir), .reset(reset),
		.cntQ(cntQ)
	);
	
	always #10 clk = ~clk;
	
	task test();
		#20 reset = 1;
		#300 reset = 0;
		#50 reset = 1;
		dir = 0;
		#300 reset = 0;
		endtask
	
initial begin
	reset = 0;
	dir = 1;
	clk = 0;
	test();
	$stop;
end

endmodule
	