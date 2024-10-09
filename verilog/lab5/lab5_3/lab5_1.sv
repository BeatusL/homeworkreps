module lab5_1 (
	input wire clk,
	input wire srst_in,
	input wire [3:0] din,
    
	output reg [7:0] q);
	
	reg [1:0] state;
	parameter s0 = 0, s1 = 1, s2 = 2;
	
	reg srst;
	reg [3:0] d;
	
	reg tmp_srst;
	reg [3:0] tmp_d;
	
	always @(posedge clk) begin
		tmp_d <= din;
		tmp_srst <= srst_in;
		
		d <= tmp_d;
		srst <= tmp_srst;
		
		
		if (srst)
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
	