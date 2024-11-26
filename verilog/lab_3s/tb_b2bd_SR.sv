`timescale 1ns/1ns
module tb_b2bd_SR;
	reg [7:0] bc;
	reg clk;
	reg [11:0] bdc, bdc_expected;
	reg [11:0] hdr;
	reg [3:0] dec, unt;
	localparam CLK_PERIOD = 10;

	initial
	begin: clk_generation
		clk = 1'b0;
		forever #(CLK_PERIOD/2) clk = ~clk;
	end

	b2bcd_SR b2bcd_SR_inst (.bc(bc), .clk(clk), .bdc(bdc));
	localparam FILE_NAME = "expected_data_b2bcd.txt";
	integer file;

    task init_data();
		integer r, line, b;
		file = $fopen(FILE_NAME, "w");
		if (file == 0) begin
			$display("Error: could not open file %s", FILE_NAME);
			$stop;
		end

		for (hdr = 4'd0; hdr <= 4'd2; hdr++) begin
			for (dec = 4'd0; dec <= 4'd9; dec++) begin
				for (unt = 4'd0; unt <= 4'd9; unt++) begin
					b = (hdr >= 4'd2 && dec >= 4'd5 && unt >= 4'd5);
					if (b) $fwrite(file, "%12b\n", {2'b0, hdr, dec, unt});
					else $fwrite(file, "%12b\n", {2'b0, hdr, dec, unt});
					if (b) break;
				end
			if (b) break;
			end
		if (b) break;
		end
		$fclose(file);
	endtask

	task test();
		bc = 0;
		file = $fopen(FILE_NAME, "r");

		while (!$feof(file)) begin
			#(12*CLK_PERIOD);
			$fscanf(file, "%12b", bdc_expected);
			if (bdc == bdc_expected) $display("Test ", bc, " passed ");
			else $display("Test ", bc," failed. Got ", bdc, ", expected", bdc_expected);
         bc++;
		end
		$fclose(file);
	endtask

	initial begin
		clk = 0;
		init_data();
		test();
		$stop;
	end

endmodule
