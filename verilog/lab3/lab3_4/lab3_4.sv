module lab3_4
(
	input [3:0] a, b,
	input sel,
	output [6:0] d7seg,
	output dig4, dig3, dig2, dig1
);
	
	reg [3:0] a1 = 4'd0;
	reg [3:0] a2 = 4'd0;
	reg [6:0] d7seg1 = 7'd0;
	reg [6:0] d7seg2 = 7'd0;



	lab3_1 #(.W(4)) lab3_1_inst (.a(a), .b(b), .dmin(a1), .dmax(a2));
	
	lab3_2 lab3_2_inst1 (.a(a1), .d7seg(d7seg1));
	
	lab3_2 lab3_2_inst2 (.a(a2), .d7seg(d7seg2));
	
	lab3_3 #(.W(7)) lab3_3_inst (.a(d7seg1), .b(d7seg2), .sel(sel), .res(d7seg)); 
	
	assign dig1 = sel;
	assign dig2 = ~sel;
	assign dig3 = 1'b0;
	assign dig4 = 1'b0; 


endmodule
