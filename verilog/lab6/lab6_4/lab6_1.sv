module lab6_1 
#(parameter w = 6)
(	input reg [w-1:0] a, b,
	input clk, rst,
	output reg [w-1:0] min, max
	);


task tsort (
	input [w-1:0] in1, in2,
	output [w-1:0] taskmin, taskmax);
	begin
		if (in1>in2) begin
			taskmin = in2;
			taskmax = in1;
		end else begin
			taskmin = in1;
			taskmax = in2;
		end
	end
endtask


always @(posedge clk) begin
	tsort(a, b, min, max);
	if (rst) begin
		min = 0;
		max = 0; end
end
	
endmodule