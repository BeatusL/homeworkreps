module lab4_2 #(
	parameter cm = 100
) (
	input wire clk,
	input wire arst,
	input wire ena,
	input wire load,
	input wire [6:0] din,
	input wire dir,
    
	output reg [6:0] q
);



always @(posedge clk or negedge arst) begin
	if (~arst) begin
		q <= 0;
	end else if (ena) begin
		if (~load) begin
			if (din > cm - 1) begin
				q <= cm - 1;
			end else begin
            q <= din;
			end
		end else begin
			if (dir) begin
				if (q == cm - 1) begin
					q <= 0;
				end else begin
					q <= q + 1; 
				end
			end else begin
				if (q == 0) begin
					q <= cm - 1;
				end else begin
					q <= q - 1;
				end
			end
		end
	end
    
end

endmodule
