module b2bd_SR (
	input [7:0] bc,
	input clk,
	output [11:0] bdc
);

	reg [7:0] shrg_bc, rg_bc_new, rg_bc_old;
	reg [3:0] rg_hdr, rg_dec, rg_unt, F_dec, F_unt, cnt_t;
	reg load, ENA;

	initial {rg_hdr, rg_dec, rg_unt, shrg_bc, cnt_t, load, ENA} = 0;

	always @(posedge clk)
	begin
		rg_bc_new <= bc;
		rg_bc_old <= rg_bc_new;
		if (rg_bc_new != rg_bc_old)
			load <= 1'd1;
		else
			load <= 1'd0;
	end

	always @(posedge clk)
	if (load) {cnt_t, ENA} <= 0;
	else if (cnt_t < 4'd8) begin
			cnt_t <= cnt_t + 4'd1;
			ENA <= 1'd1;
	end else
			ENA <= 0;

	always @(posedge clk)
	if (load) shrg_bc <= rg_bc_new;
	else if (ENA) shrg_bc <= shrg_bc << 1;

	always @(posedge clk)
	if (load) {rg_hdr, rg_dec, rg_unt} <= 0;
	else if (ENA) {rg_hdr, rg_dec, rg_unt} <= {rg_hdr[2:0], F_dec, F_unt, shrg_bc[7]};

	always @(*)
	begin
		F_unt = (rg_unt < 4'd5) ? rg_unt : (rg_unt + 4'd3);
		F_dec = (rg_dec < 4'd5) ? rg_dec : (rg_dec + 4'd3);
	end

	assign bdc = {rg_hdr, rg_dec, rg_unt};

endmodule
