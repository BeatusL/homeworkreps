module d_rg #(parameter W=4) (
	input [W-1:0] a, b, c, d,
	input clk, rst_ni,
	output [W-1:0] ai, bi, ci, di
);

reg [W-1:0] reg_a=0, reg_b=0, reg_c=0, reg_d=0;

always @(posedge clk) begin
	if (!rst_ni) {reg_a, reg_b, reg_c, reg_d} = 0;
	else {reg_a, reg_b, reg_c, reg_d} = {a, b, c, d};
end

assign {ai, bi, ci, di} = {reg_a, reg_b, reg_c, reg_d};

endmodule
