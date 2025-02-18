module ss_cntr #(parameter W = 4) (
	input clk, rst_n,
	input [3:0] a, b, c, d,
	output [6:0] ss,
	output [4:1] dig
);

wire [6:0] ssi;
wire [4:1] digi;
wire [3:0] ai, bi, ci, di, mo;
wire [1:0] sel;
wire rst_ni;
wire ENA;

d_rg #4 d_rg_inst (
	.a(a), .b(b), .c(c), .d(d),
	.clk(clk),
	.rst_ni(rst_ni),
	.ai(ai), .bi(bi), .ci(ci), .di(di)
);

rst_rg rst_rg_inst (
	.clk(clk),
	.rst_n(rst_n),
	.rst_n_i(rst_ni)
);

MUX #4 MUX_inst (
	.ai(ai), .bi(bi), .ci(ci), .di(di),
	.sel(sel),
	.mo(mo)
);

FSM FSM_inst (
	.ENA(ENA),
	.clk(clk),
	.rst_ni(rst_ni),
	.sel(sel),
	.digi(digi)
);

cnt_div #W cnt_div_inst (
	.clk(clk),
	.rst_n(rst_ni),
	.ENA(ENA)
	
);

b2ss b2ss_inst (
	.a(mo),
	.d7seg(ssi)
);

ss_rg ss_rg_inst (
	.ssi(ssi),
	.clk(clk),
	.rst_ni(rst_ni),
	.ss(ss)
);

dig_rg dig_rg_inst (
	.digi(digi),
	.clk(clk),
	.rst_ni(rst_ni),
	.dig(dig)
);

endmodule
