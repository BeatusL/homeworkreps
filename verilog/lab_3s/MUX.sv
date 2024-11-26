module MUX #(parameter W=4) (
	input [W-1:0] ai, bi, ci, di,
	input [1:0] sel,
	output reg [W-1:0] mo
);

always @(*) begin
	case (sel)
		2'b10 : mo <= ai;
		2'b11 : mo <= bi;
		2'b01 : mo <= ci;
		2'b00 : mo <= di;
	endcase
end

endmodule
