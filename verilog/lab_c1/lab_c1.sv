module lab_c1 (
	input logic clk, dir, reset,
	output logic [3:0] cntQ
	);
	
	
	always_ff @(posedge clk) begin
		if (!reset)
			cntQ <= 0;
		else begin
			if (dir)
				if (cntQ == 4'b1011) cntQ = 4'b0000;
				else cntQ <= cntQ + 4'b0001;
			else 
				if (cntQ == 4'b0000) cntQ = 4'b1011;
				else cntQ <= cntQ - 4'b0001;
		end
	end
	
endmodule
