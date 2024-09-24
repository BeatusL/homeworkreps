module lab3_1
#(parameter W = 4)
(
	input [W-1:0] a, b,
	output reg [W-1:0] dmin, dmax);


always @* begin
	if (a > b) begin
		dmin = b;
		dmax = a; end
	else begin
		dmin = a;
		dmax = b; end
end

endmodule