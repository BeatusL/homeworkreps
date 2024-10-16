module lab6_2 
#(parameter w = 6)
(	input reg [w-1:0] a, b,
	input clk, rst,
	output reg [w-1:0] min, max
	);


function [w-1:0] fmin;
input [w-1:0] a, b;
begin
	fmin = (a>b)? b:a;
end
endfunction

function [w-1:0] fmax;
input [w-1:0] a, b;
begin
	fmax = (a>b)? a:b;
end
endfunction


always @(posedge clk) begin
	min = fmin(a,b);
	max = fmax(a,b);
	if (rst) begin
			min = 0;
			max = 0; end
	end


endmodule