`timescale 100ns/100ns
module tb_labSIM2_3;
reg clk;
reg [2:0] da;
reg [7:0] q;

initial clk = 1'b0;
always #1 clk = ~clk;

always @(negedge clk) begin
	#250 da = 3'b000;
	#100 da = 3'b001;
	#100 da = 3'b010;
	#100 da = 3'b011;
	#100 da = 3'b100;
	#100 da = 3'b101;
	#100 da = 3'b110;
	#100 da = 3'b111;
	#100;
end

labSIM2_3 lalala (.clk(clk), .da(da), .q(q));

initial begin
	$display("\t\t Time | CLK | da | q");
	$monitor($time,,,,,,clk,,,,,,da,,,,,q);
	#1000 $stop;
end

endmodule
	