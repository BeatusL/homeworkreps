`timescale 1ns/1ns
module tb_b2bd_ROM;
	reg [7:0] bc;
	reg clk;
	reg [11:0] bdc_1, bdc_2, bdc_3, bdc_expected;
	localparam CLK_PERIOD = 10;
	localparam FILE_NAME = "expected_data_b2bd.txt";
	
	initial begin
		clk = 1'b0;
		forever #(CLK_PERIOD/2) clk = ~clk;
	end
	
	b2bd_ROM b2bcd_ROM_inst (.bc(bc), .clk(clk), .bdc(bdc_3));
	b2bd_LOG b2bcd_LOG_inst (.bc(bc), .clk(clk), .bdc(bdc_2));
	b2bd_SR  b2bcd_SR_inst  (.bc(bc), .clk(clk), .bdc(bdc_1));

	task test();
		integer file;
		bc = 0;
		file = $fopen(FILE_NAME, "r");
		while (!$feof(file)) begin
			#(12*CLK_PERIOD);
			$fscanf(file, "%12b", bdc_expected);
			if ({bdc_1, bdc_2, bdc_3} == {bdc_expected, bdc_expected, bdc_expected})
				$display("Test ", bc, " passed ");
			else $display("Test ", bc," failed. Got ", bdc_1, ", expected", bdc_expected);
         bc++;
		end
		$fclose(file);
	endtask

	initial begin
		clk = 0;
		test();
		$stop;
	end

endmodule
