module lab6_4 
#(parameter Type = "lab6_2", w = 6)
(	(* altera_attribute = "-name IO_STANDARD \"3.3-V LVCMOS\"", chip_pin = "88, 89" *) input reg [w-1:0] a, 
	(* altera_attribute = "-name IO_STANDARD \"3.3-V LVCMOS\"", chip_pin = "90, 91" *) input reg [w-1:0] b, 
	(* altera_attribute = "-name IO_STANDARD \"3.3-V LVCMOS\"", chip_pin = "49, 46" *) input reg [w-1:0] c, 
	(* altera_attribute = "-name IO_STANDARD \"3.3-V LVCMOS\"", chip_pin = "25, 24" *) input reg [w-1:0] d,
	(* altera_attribute = "-name IO_STANDARD \"3.3-V LVCMOS\"", chip_pin = "23" *) input clk, 
	(* altera_attribute = "-name IO_STANDARD \"2.5-V\"", chip_pin = "64" *) input rst,
	(* altera_attribute = "-name IO_STANDARD \"2.5-V\"", chip_pin = "65, 66" *) output reg [w-1:0] min,
	(* altera_attribute = "-name IO_STANDARD \"2.5-V\"", chip_pin = "67, 68" *) output reg [w-1:0] midl,
	(* altera_attribute = "-name IO_STANDARD \"2.5-V\"", chip_pin = "69, 70" *) output reg [w-1:0] midh,
	(* altera_attribute = "-name IO_STANDARD \"2.5-V\"", chip_pin = "71, 72" *) output reg [w-1:0] max
	);

reg [w-1:0] a_, b_, c_, d_;
reg [w-1:0] min1, min2, min3, max1, max2, max3;
reg [w-1:0] min_, min1_, min2_, min3_, max_, max1_, max2_, max3_, midl_, midh_;


always @(posedge clk) begin
	if (rst) begin
		a_ <= 0;
		b_ <= 0;
		c_ <= 0;
		d_ <= 0; end
	else begin
		a_ <= a;
		b_ <= b;
		c_ <= c;
		d_ <= d; end
end

	
generate
if (Type == "lab_1") begin :v1
	lab6_1 #(.w(w)) 
	l11 (a_, b_, clk, rst, min1_, max1_);
	l12 (c_, d_, clk, rst, min2_, max2_),
	l13 (min1, min2, clk, rst, min_, max3),
	l14 (max1, max2, clk, rst, min3, max_),
	l15 (min3, max3, clk, rst, midl_, midh_); end
	
else 						begin :v2
	lab6_2 #(.w(w)) 
	l21 (a_, b_, clk, rst, min1_, max1_),
	l22 (c_, d_, clk, rst, min2_, max2_),
	l23 (min1, min2, clk, rst, min_, max3_),
	l24 (max1, max2, clk, rst, min3_, max_),
	l25 (min3, max3, clk, rst, midl_, midh_); end
endgenerate


always @(posedge clk) begin
	min1 <= min1_;
	max1 <= max1_;
	min2 <= min2_;
	max2 <= max2_; end

always @(posedge clk) begin
	min <= min_;
	max3 <= max3_;
	min3 <= min3_;
	max <= max_; end
	
always @(posedge clk) begin
	midl <= midl_;
	midh <= midh_;end

	
endmodule