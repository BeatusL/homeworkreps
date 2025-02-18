module dig_rg (
	input [4:1] digi,
	input clk, rst_ni,
	output [4:1] dig
);

reg [3:0] reg_data = 0;

always @(posedge clk) begin
	if (!rst_ni) reg_data = 0;
	else reg_data <= digi;
end

assign dig[4:1] = reg_data;

endmodule
