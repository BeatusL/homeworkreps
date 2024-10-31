module ROM_read (
	input CLK,
	input reset_n,
	input enable,
	input read_ROM,
	input [4:0] adr_limit,
	output reg [4:0] ROM_adr,
	output reg done
);

always @(posedge CLK, negedge reset_n)
	if (!reset_n) begin
		ROM_adr <= 5'd0;
		done <= 1'd0;
	end
	else
		if (enable)
			if (!read_ROM) begin
				ROM_adr <= 5'd0;
				done <= 1'd0;
			end
			else
				if (ROM_adr == adr_limit) begin
					ROM_adr <= ROM_adr;
					done <= 1'd1;
				end
				else begin
					ROM_adr <= ROM_adr + 5'd1;
					done <= 1'd0;
				end
endmodule
