`timescale 1ns/100ps
module tb_labSIM2_1();
localparam CLKPERIOD = 20;

reg 	clk;
reg 	srst_in;
reg 	[3:0] din;
wire [7:0] q;

labSIM2_1 DUT (.clk(clk), .srst_in(srst_in), .din(din), .q(q));

initial begin: clk_generation
clk = 1'b0; forever #(CLKPERIOD/2) clk= ~clk; end



integer cnt;
initial begin:labSIM2_test
srst_in = 1'b0;
din = 4'h0;
cnt = 0;
forever begin @(negedge clk);
	if (cnt >= 50)
		break;
	if (cnt > 15 && din == 4'h3)
			din = 4'h4;
			
		srst_in = 1'b1;
		din = din + 4'h1;
		cnt = cnt + 1;

	end
end


always @ (cnt)
	begin
		if ((cnt == 5 || (cnt > 8 && cnt < 22)) && q != 8'h55)
			$display("Test %d failed", cnt);
		if ((cnt == 6 || cnt == 7 || (cnt > 21 && cnt < 26)) && q != 8'hff)
			$display("Test %d failed", cnt);
		if ((cnt == 4 || cnt > 26) && q != 8'h00)
			$display("Test %d failed", cnt);
	end
	

initial #620 $stop;

endmodule


