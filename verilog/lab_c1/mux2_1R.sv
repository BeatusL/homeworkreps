module mux2_1R #(parameter W=8) (
	input logic clk, sel,
	input logic [W-1:0] dA, dB,
	output reg [W-1:0] muxOUT
);

always_ff @(posedge clk) begin
	if (sel)
		muxOUT <= dA;
	else 
		muxOUT <= dB;
end

endmodule
