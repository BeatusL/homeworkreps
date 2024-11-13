`timescale 1ns/100ps
module labSIM2_1 (
	input clk,
	input srst_in,
	input [3:0] din,
    
	output reg [7:0] q);
	
	reg [1:0] state;
	parameter s0 = 0, s1 = 1, s2 = 2;
	
	reg [1:0] srst_temp;
	reg [7:0] din_temp;
	reg [3:0] d;
	
	reg srst;
	
	always @(posedge clk) begin
		din_temp <= {din, din_temp[7:4]};
		srst_temp <= {srst_in, srst_temp[1]}; end
	
	
	always @(posedge clk) begin
		d <= din_temp[3:0];
		
		srst <= srst_temp[0];
		
		
		if (!srst)
			state <= s0;
		else
			case (state)
				s0: if (d == 4'h1) state <= s1;
				s1: if (d == 4'h2) state <= s2;
				s2: if (d == 4'h4) state <= s1;
					else if(d == 4'h8) state <= s0;
			endcase
	end
	
	always @ (state)
	begin
		case (state)
			s0: q = 8'h00;
			s1: q = 8'h55;
			s2: q = 8'hff;
			default: q = 8'h00;
		endcase
	end
	
endmodule
	