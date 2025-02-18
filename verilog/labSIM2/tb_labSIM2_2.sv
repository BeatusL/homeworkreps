`timescale 100ns/1ps
module tb_labSIM2_2;
integer i, r, num_sequences;
reg [1:0] test [255:0][3:0];
initial $readmemb("input.txt", test);
reg [1:0] res [255:0][3:0];
initial begin 
	integer file;
	file = $fopen("output.txt", "r");
	num_sequences = 0;
	while (!$feof(file)) begin
		for (r = 0; r < 4; r = r + 1) begin
			if ($fscanf(file, "%2b", res[num_sequences][r]) == 0)
				break;
		end
		num_sequences = num_sequences + 1;
	end
	$fclose(file);
end


reg clk, rst;
initial clk = 1'b0;
initial rst = 1'b0;
always #10 clk = ~clk;

reg [1:0] a, b, c, d;
wire [1:0] min, midl, midh, max;

initial begin
	for (i = 0; i < num_sequences; i = i + 1) begin
		@(negedge clk);
		#100 a = test[i][0]; b = test[i][1]; c = test[i][2]; d = test[i][3]; rst = 1;
		@(posedge clk);
		@(posedge clk); #100;
		if (min == res[i][0] && midl == res[i][1] && midh == res[i][2] && max == res[i][3]) begin
			$display("Test %d passed", i);
		end else begin
			$display("Test %d failed", i);
		end
	end
end

lab6_3 MUX(.a(a), .b(b), .c(c), .d(d), .clk(clk), .rst(rst), .min(min), .midl(midl), .midh(midh), .max(max));
initial #10000 $stop;
endmodule

