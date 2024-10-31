module Top_module (
	input CLK,
	input key_reset,
	input key_restart,
	output led_done,
	output [4:0] led_ROM
);

wire [4:0] ROM_adr;
wire [4:0] adr_limit;
wire read_ROM;
wire Cout;
wire ENA;
wire [25:0] Qcntdiv;

cnt_div U1 (
	.CLK (CLK),
	.reset_n (key_reset),
	.Cout (ENA),
	.Qcntdiv (Qcntdiv),
);

ROM_read U2 (
	.CLK (CLK),
	.reset_n (key_reset),
	.read_ROM (key_restart),
	.enable (ENA),
	.adr_limit (adr_limit),
	.ROM_adr (ROM_adr),
	.done (led_done)
);

ROM U3 (
	.address (ROM_adr),
	.clock (CLK),
	.q (led_ROM)
);

ROM_adr_limit U4 (
	.result (adr_limit)
);

endmodule
