module lab4_1 #(
    parameter cmd = 10
) (
	input wire clk,    
	input wire srst,    
	input wire ena, 
    
	output reg cout   
);

reg [31:0] count;       

always @(posedge clk) begin
	if (ena) begin
		if (count == cmd - 1) begin
			count <= 0;
			cout <= 1;
		end else begin
			count <= count + 1;
			cout <= 0;
		end if (~srst) begin
			count <= 0;
			cout <= 0;
		end
	end
end

endmodule
