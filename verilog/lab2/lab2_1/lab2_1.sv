module lab2_1
#(parameter WIDTH=2, TYPE="minsel")
(
	input [WIDTH-1:0] a, b, c, d,
	output [WIDTH-1:0] out);


    assign out = (TYPE=="minsel") ? (a < b ? a : b) < (c < d ? c : d) 
                     ? (a < b ? a : b) 
                     : (c < d ? c : d)
							: (a > b ? a : b) > (c > d ? c : d) 
                     ? (a > b ? a : b) 
                     : (c > d ? c : d); 
							
endmodule

