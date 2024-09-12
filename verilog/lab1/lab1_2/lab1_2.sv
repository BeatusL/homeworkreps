module lab1_2
(	input [1:0] sw1, sw0,
	input pba,
	output [1:0] led);
	
assign led[0] = (sw1[0] & pba) | (sw0[0] & ~pba);
assign led[1] = (sw1[1] & pba) | (sw0[1] & ~pba);

endmodule