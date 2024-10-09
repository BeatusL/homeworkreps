module lab5_2
#(parameter DATA_WIDTH=7)
(	input [(DATA_WIDTH - 1):0] da, db,
	input clk,
	output reg [(2*DATA_WIDTH - 1):0] q);
	
reg [2*DATA_WIDTH - 1:0] rom[2**(2*DATA_WIDTH)-1:0];
reg [(DATA_WIDTH - 1):0] ta, tb, ia, jb;

initial begin: INIT
	integer i, j;
	for (i=0; i<=2**DATA_WIDTH-1; i=i+1)
		for (j=0; j<=2**DATA_WIDTH-1; j=j+1)
		begin
			ia = i;
			jb = j;
			rom[{ia,jb}] = ia * jb;
		end
end

always @ (posedge clk)
	begin
		ta <= da;
		tb <= db;
	end

always @ (posedge clk)
	q <= rom[{ta, tb}];

endmodule
