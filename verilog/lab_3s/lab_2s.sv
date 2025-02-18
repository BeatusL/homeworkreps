module lab_2s #(parameter W=10000) (
	(* altera_attribute = "-name IO_STANDARD \"3.3-V LVCMOS\"", chip_pin = "23" *)
	input clk,
	(* altera_attribute = "-name IO_STANDARD \"3.3-V LVCMOS\"", chip_pin = "64" *)
	input rst_n,
	(* altera_attribute = "-name IO_STANDARD \"3.3-V LVCMOS\"", chip_pin = "87, 133, 86, 77, 85, 76, 84" *)
	output [6:0] ss,
	(* altera_attribute = "-name IO_STANDARD \"3.3-V LVCMOS\"", chip_pin = "73, 80, 74, 83" *)
	output [4:1] dig
);

parameter a_data = 4'b1111, b_data = 4'b0111, c_data = 4'b0011, d_data = 4'b0000;

ss_cntr #W ss_cntr_inst (
	.clk(clk),
	.rst_n(rst_n),
	.a(a_data), .b(b_data), .c(c_data), .d(d_data),
	.ss(ss),
	.dig(dig)
);

endmodule
