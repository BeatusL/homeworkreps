module cnt_div (
	input CLK,
	input reset_n,
	output reg Cout,
	output reg [25:0] Qcntdiv
);

always @(posedge CLK, negedge reset_n)
	if (!reset_n)
		Qcntdiv <= 26'd0;
	else
		Qcntdiv <= Qcntdiv + 26'd1;
always @(posedge CLK, negedge reset_n)
	if (!reset_n)
		Cout <= 1'd0;
	else
		Cout <= (Qcntdiv == (2**26-2));
endmodule
