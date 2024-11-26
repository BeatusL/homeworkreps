module lab_1s #(parametr = 4) (
	(* altera_attribute = "-name IO_STANDARD \"3.3-V LVCMOS\"", chip_pin = "23" *)
	input clk,
	(* altera_attribute = "-name IO_STANDARD \"2.5-V\"", chip_pin = "64" *)
	input rst_n,
	(* altera_attribute = "-name IO_STANDARD \"2.5-V\"", chip_pin = "65, 66, 67, 68, 69, 70, 71, 72" *)
	output [7:0] dout
);

wire rst_n_i;
wire [7:0] dint;
wire ena;

cnt_div #parametr cnt_div_inst (
	.clk(clk),
	.rst_n(rst_n_i),
	.ena(ena)
);

rst_rg rst_reg_inst (
	.clk(clk),
	.rst_n(rst_n),
	.rst_n_i(rst_n_i)
);

led_drv led_drv_inst (
	.clk(clk),
	.rst_n(rst_n_i),
	.ena(ena),
	.dint(dint)
);

led_rg led_rg_inst (
	.clk(clk),
	.rst_n(rst_n_i),
	.dint(dint),
	.dout(dout)
);

endmodule
