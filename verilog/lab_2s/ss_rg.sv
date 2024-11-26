module ss_rg (
	input [6:0] ssi,
	input clk, rst_ni,
	output [6:0] ss
);

reg [6:0] reg_data = 0;

always @(posedge clk) begin
	if (!rst_ni) reg_data = 0;
	else reg_data <= ssi;
end

assign ss = reg_data;

endmodule
