module lab6_1 
#(parameter w = 6)
(	input [w-1:0]a, b,
	output [w-1:0]min, max
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


always @*
	tsort(a, b, min, max);

	
endmodule
