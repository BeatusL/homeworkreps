module lab3_3
#(parameter W = 4)
(
	input [W-1:0] a, b,
	input sel,
	output reg [W-1:0] res);


always @* begin
	if(sel)
		res = a;
	else
		res = b;
end

endmodule