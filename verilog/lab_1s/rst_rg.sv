module rst_rg (
	input clk,
	input rst_n,
	output rst_n_i
);
	
	reg rst_n_1;
	reg rst_n_2;

	always @(posedge clk) begin
		rst_n_1 <= rst_n;
		rst_n_2 <= rst_n_1;
	end
	
	assign rst_n_i = rst_n_2;
	
endmodule
