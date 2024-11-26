module lab_3s #(parameter div_factor = 4, TYPE = "ROM") (
	(* altera_attribute = "-name IO_STANDARD \"3.3-V LVCMOS\"", chip_pin = "23" *)
	input clk,
	(* altera_attribute = "-name IO_STANDARD \"3.3-V LVCMOS\"", chip_pin = "88, 89, 90, 91, 49, 46, 25, 24" *)
	input [7:0] bc,
	(* altera_attribute = "-name IO_STANDARD \"3.3-V LVCMOS\"", chip_pin = "84, 76, 85, 77, 86, 133, 87" *)
	output [6:0] ss,
	(* altera_attribute = "-name IO_STANDARD \"3.3-V LVCMOS\"", chip_pin = "73, 80, 74, 83" *)
	output [4:1] dig
);

wire [11:0] bdc;

ss_cntr #div_factor (
	.clk(clk),
	.rst_n(1'b1),
	.a(4'h0), .b(bdc[11:8]), .c(bdc[7:4]), .d(bdc[3:0]),
	.ss(ss),
	.dig(dig)
);

generate 
	case (TYPE)
		"LOG":
			b2bd_LOG(
				.clk(clk),
				.bc(bc),
				.bdc(bdc)
			);
		"SRR":
			b2bd_SR(
				.clk(clk),
				.bc(bc),
				.bdc(bdc)
			);
		default:
			b2bd_ROM(
				.clk(clk),
				.bc(bc),
				.bdc(bdc)
			);
	endcase
endgenerate

endmodule
