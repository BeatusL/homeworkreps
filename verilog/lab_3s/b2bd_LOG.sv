module b2bd_LOG (
	input clk,
	input [7:0] bc,
	output reg [11:0] bdc
);

	reg [3:0] temp_a, temp_b, temp_c, temp_dl, temp_el, temp_dh, temp_eh;
	reg [7:0] rg_bc;

	function [3:0] b2bd (input [3:0] bc);
		b2bd = (bc < 4'b0101) ? bc : (bc + 4'b0011);
	endfunction

	initial rg_bc = 0;

	always @(posedge clk) rg_bc <= bc;

	always @(*) begin
		temp_a = b2bd({1'b0, bc[7:5]});
		temp_b = b2bd({temp_a[2:0], bc[4]});
		temp_c = b2bd({temp_b[2:0], bc[3]});
		temp_dl = b2bd({temp_c[2:0], bc[2]});
		temp_dh = b2bd({1'b0, temp_a[3], temp_b[3], temp_c[3]});
		temp_el = b2bd({temp_dl[2:0], bc[1]});
		temp_eh = b2bd({temp_dh[2:0], temp_dl[3]});
	end

	always @(posedge clk)
		bdc <= {temp_dh[3], temp_eh, temp_el, rg_bc[0]};

endmodule
