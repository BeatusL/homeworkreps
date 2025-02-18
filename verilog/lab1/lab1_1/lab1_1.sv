module lab1
(  input 	sw0, sw1, sw2,
	output 	led0, led1, led2, led3,
	output supply0 led4, led5, led6,
	output supply0 led7, led8, led9);

wire temp;

assign temp = sw0 | sw1;
assign  led0 = 1'b1;
assign  led1 = sw2 & temp;
assign  led2 = ~temp;
assign  led3 = 4'b1;

endmodule