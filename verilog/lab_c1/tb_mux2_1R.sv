`timescale 1ns/1ns
module tb_mux2_1R;
	parameter W = 4;
	logic clk, sel;
	logic [W-1:0] dA, dB;
	logic [W-1:0] muxOUT;
	
	always #10 clk = ~clk;
	
	mux2_1R inst (
		.clk(clk),
		.sel(sel),
		.dA(dA),
		.dB(dB),
		.muxOUT(muxOUT)
	);
	
	task test();
		dA = 4'b0101;
		dB = 4'b1010;
		sel = 1;
		#20 $monitor("%0t\t%h\t%h\t%h\t%h", $time, clk, dA, dB, muxOUT);
		if (muxOUT == 4'b0101) $display("Test passed");
		else $display("Test failed");
		#50 sel = 0;
		#20 $monitor("%0t\t%h\t%h\t%h\t%h", $time, clk, dA, dB, muxOUT);
		if (muxOUT == 4'b1010) $display("Test passed");
		else $display("Test failed");
		#50 dA = 4'b0000;
		dB = 4'b1111;
		sel = 1;
		#20 $monitor("%0t\t%h\t%h\t%h\t%h", $time, clk, dA, dB, muxOUT);
		if (muxOUT == 4'b0000) $display("Test passed");
		else $display("Test failed");
		#50 sel = 0;
		#20 $monitor("%0t\t%h\t%h\t%h\t%h", $time, clk, dA, dB, muxOUT);
		if (muxOUT == 4'b1111) $display("Test passed");
		else $display("Test failed");
		
	endtask
	
	initial begin
		clk = 0;
		test();
		#50 $stop;
	end

endmodule
		