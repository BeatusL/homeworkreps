`timescale 1ns/100ps
module tb_lab_QMS1();

reg tb_clk;
reg tb_reset;
wire [7:0] tb_led;
				
lab_QMS1 #(5) 
DUT (
	.LED		(tb_led		),
	.CLK 		(tb_clk		),
	.RESET	(tb_reset	)
);
initial 
begin
	tb_clk 		= 1'b0;
	tb_reset 	= 1'b1; 
		
	#100 tb_reset = 0;
	#1000 $stop;
end
	
always #10 tb_clk = ~tb_clk;

endmodule
