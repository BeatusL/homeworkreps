module lab (
	input logic clk, reset, sel,
	output reg [4:1] dOUT
);

logic [4:1] dA, dB;

lab_c1 CNT_m12_R1 (
		.clk(clk), .dir(1), .reset(reset),
		.cntQ(dA)
	);

lab_c1 CNT_m12_R2 (
		.clk(clk), .dir(0), .reset(reset),
		.cntQ(dB)
	);

	mux2_1R inst (
		.clk(clk),
		.sel(sel),
		.dA(dA),
		.dB(dB),
		.muxOUT(dOUT)
	);

endmodule
