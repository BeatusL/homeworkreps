module led_drv (
	input clk, rst_n, ena,
	output [7:0] dint
);

reg [4:0] counter = 2'd0;
reg [7:0] ROM [31:0];
reg [7:0] dint_reg;

initial $readmemb("ROM_data.txt", ROM);

always @(posedge clk) begin
	if(!rst_n)
		counter <= 2'd0;
	else if (ena)
		counter <= counter + 2'd1;
end

always @(posedge clk) begin
	dint_reg = ROM[counter];
end

assign dint = dint_reg;

endmodule
	