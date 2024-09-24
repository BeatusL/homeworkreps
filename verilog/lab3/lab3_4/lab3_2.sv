module lab3_2
(
	input [3:0] a,
	output reg [6:0] d7seg);
	reg [6:0] arr[15:0];

initial begin
	arr[0] = 7'h3f;
	arr[1] = 7'h06; 
	arr[2] = 7'h5b; 
	arr[3] = 7'h4f; 
	arr[4] = 7'h66; 
	arr[5] = 7'h6d; 
	arr[6] = 7'h7d; 
	arr[7] = 7'h07; 
	arr[8] = 7'h7f; 
	arr[9] = 7'h6f; 
	arr[10] = 7'h77;
	arr[11] = 7'h7c;
	arr[12] = 7'h39;
	arr[13] = 7'h5e;
	arr[14] = 7'h79; 
	arr[15] = 7'h71; end
	

always @*
	d7seg = arr[a];

endmodule
