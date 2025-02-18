module tb_FSM;
	reg clk, rst_ni, ENA;
	reg [1:0] sel, sel_expected;
	reg [4:1] digi, digi_expected;
	
	always #10 clk = ~clk;
	
	FSM FSM_inst (
		.ENA(ENA),
		.clk(clk),
		.rst_ni(rst_ni),
		.sel(sel),
		.digi(digi)
	);
	
	task test();
		integer file;
		integer k_for_reset;
		ENA = 1;
		rst_ni = 0;
		k_for_reset = 0;
		
		@(posedge clk);
		rst_ni = 1;
		file = $fopen("expected_data.txt", "r");
		while (!$feof(file)) begin
			$fscanf(file, "%2b %4b", sel_expected, digi_expected);
			if (k_for_reset == 9) begin
				rst_ni = 0;
				@(posedge clk);
				rst_ni = 1;
			end
			k_for_reset++;
			
			@(posedge clk);
			if(sel == sel_expected && digi == digi_expected)
				$display("Test passed");
			else
				$display("Test failed");
		end
	endtask
	
	initial begin
		clk = 0;
		test();
		$stop;
	end

endmodule
