module db_lab
	(input logic clk);

logic [1:0] db_source;
reg [4:1] db_dOUT;

lab lab (
	.clk(clk), .sel(db_source[0]), .reset(db_source[1]),
	.dOUT(db_dOUT)
);

ISSPE_lab uut (
	.probe(db_dOUT),
	.source_clk(clk),
	.source(db_source)
);


endmodule
