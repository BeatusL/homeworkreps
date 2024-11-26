module cnt_div #(parametr = 4) (
	input clk,
	input rst_n,
	output ena
);
	
	reg [31:0] div_counter = 32'b0;
	
	always @(posedge clk)
		if (!rst_n || div_counter == parametr - 1) div_counter <= 32'b0;
		else div_counter <= div_counter + 1;
		
	assign ena = (parametr - 1 == div_counter);
	
endmodule
