//lpm_shiftreg CBX_SINGLE_OUTPUT_FILE="ON" LPM_DIRECTION="LEFT" LPM_TYPE="LPM_SHIFTREG" LPM_WIDTH=16 clock data enable load q shiftin shiftout sset
//VERSION_BEGIN 18.1 cbx_mgl 2018:09:12:13:10:36:SJ cbx_stratixii 2018:09:12:13:04:24:SJ cbx_util_mgl 2018:09:12:13:04:24:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



// Copyright (C) 2018  Intel Corporation. All rights reserved.
//  Your use of Intel Corporation's design tools, logic functions 
//  and other software and tools, and its AMPP partner logic 
//  functions, and any output files from any of the foregoing 
//  (including device programming or simulation files), and any 
//  associated documentation or information are expressly subject 
//  to the terms and conditions of the Intel Program License 
//  Subscription Agreement, the Intel Quartus Prime License Agreement,
//  the Intel FPGA IP License Agreement, or other applicable license
//  agreement, including, without limitation, that your use is for
//  the sole purpose of programming logic devices manufactured by
//  Intel and sold by Intel or its authorized distributors.  Please
//  refer to the applicable agreement for further details.



//synthesis_resources = lpm_shiftreg 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  mg7id
	( 
	clock,
	data,
	enable,
	load,
	q,
	shiftin,
	shiftout,
	sset) /* synthesis synthesis_clearbox=1 */;
	input   clock;
	input   [15:0]  data;
	input   enable;
	input   load;
	output   [15:0]  q;
	input   shiftin;
	output   shiftout;
	input   sset;

	wire  [15:0]   wire_mgl_prim1_q;
	wire  wire_mgl_prim1_shiftout;

	lpm_shiftreg   mgl_prim1
	( 
	.clock(clock),
	.data(data),
	.enable(enable),
	.load(load),
	.q(wire_mgl_prim1_q),
	.shiftin(shiftin),
	.shiftout(wire_mgl_prim1_shiftout),
	.sset(sset));
	defparam
		mgl_prim1.lpm_direction = "LEFT",
		mgl_prim1.lpm_type = "LPM_SHIFTREG",
		mgl_prim1.lpm_width = 16;
	assign
		q = wire_mgl_prim1_q,
		shiftout = wire_mgl_prim1_shiftout;
endmodule //mg7id
//VALID FILE
