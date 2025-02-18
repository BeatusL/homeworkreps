`timescale 100ns/100ns
module tb_led_drv;
	reg clk;
	reg rst_n;
	reg ena;
	reg [7:0] dint;
	integer file;
	reg [7:0] expected_data;
	integer temp;
	integer k;

initial begin
	file = $fopen("expected_data.txt", "r");
	k = 0;
	while (!$feof(file)) begin
		$fscanf(file, "%8b", temp);
		k++;
	end
	$fclose(file);
end

led_drv led_drv (
	.clk(clk),
	.rst_n(rst_n),
	.ena(ena),
	.dint(dint)
);

	always #10 clk = ~clk;
	
	task test();
		file = $fopen("expected_data.txt", "r");
		rst_n = 1;
		ena = 1;
		for (int i = 0; i < k-1; i++) begin
			$fscanf(file, "%8b", expected_data);
			@(posedge clk);
			if (dint == expected_data) $display("Test %d passed", i);
			else $display("Test", i, "failed. Actual =", dint, " expected =", expected_data);
		end
		
		$fclose(file);
		
	endtask
	
	initial begin
		clk = 0;
		#10
		test();
		$stop;
	end

endmodule
		