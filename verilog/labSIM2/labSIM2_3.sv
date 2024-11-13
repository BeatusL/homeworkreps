module labSIM2_3
#(parameter N=8) (
	input clk,
	input reg [2:0] da,
	output reg [N-1:0] q);

	reg [N-1:0] ROM [N-1:0];
	
	initial begin
		$readmemb("rom_input.txt", ROM);
	end
	
	reg [N-1:0] a;
	
	always @ (posedge clk)
		a <= da;
		
	always @ (posedge clk)
		q <= ROM[a];
	
	endmodule
	