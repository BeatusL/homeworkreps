module lab6_2 
#(parameter w = 6)
(	input [w-1:0]a, b,
	output [w-1:0]min, max
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


assign min = fmin(a,b);
assign max = fmax(a,b);


endmodule
