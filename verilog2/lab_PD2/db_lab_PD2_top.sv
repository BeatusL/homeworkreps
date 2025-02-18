module db_lab_PD2_top (
	(* altera_attribute = "-name IO_STANDARD \"3.3-V LVCMOS\"", chip_pin = "23" *)
	//"23" for miniDilab-CIV
	//"R8" for DE0_nano
	//"N5" for MAX10 NEEK
	input bit clk
);

	bit reset;
	bit [3:0] dout;
SP_unit u0 (
	.source (reset),
	.source_clk (clk)
	);
lab_PD2_top UUT (.*);
endmodule
