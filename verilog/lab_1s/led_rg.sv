module led_rg (
	input [7:0] dint,
	input clk,
	input rst_n,
	output [7:0] dout
);

reg [7:0] reg_data = 8'b0;
always @(posedge clk) begin
	if (!rst_n) reg_data <= 0;
	else reg_data <= dint;
end

assign dout = reg_data;

endmodule
