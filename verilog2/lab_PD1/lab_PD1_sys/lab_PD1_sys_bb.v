
module lab_PD1_sys (
	clk_clk,
	reset_reset_n,
	delay_out_valid,
	delay_out_data,
	alu0_out_data,
	alu0_out_ready,
	alu0_out_valid,
	alu1_out_data,
	alu1_out_ready,
	alu1_out_valid);	

	input		clk_clk;
	input		reset_reset_n;
	output		delay_out_valid;
	output	[31:0]	delay_out_data;
	output	[31:0]	alu0_out_data;
	input		alu0_out_ready;
	output		alu0_out_valid;
	output	[31:0]	alu1_out_data;
	input		alu1_out_ready;
	output		alu1_out_valid;
endmodule
