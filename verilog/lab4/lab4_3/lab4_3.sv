module lab4_3 (
	input wire clk,
	input wire rst,
	input wire load,
	input wire [6:0] din,
	input wire dir,
    
	output wire [6:0] q);
	
	reg rst_int;
	reg load_int;
	reg [6:0] din_int;
	reg dir_int;
	
	reg tmp_rst_int;
	reg tmp_load_int;
	reg [6:0] tmp_din_int;
	reg tmp_dir_int;
	
	reg cmd_cout;
	reg [6:0] tmp_q;
	
	parameter top_cmd = 4;
	parameter cmd_par = 14;
	
	
	always @(posedge clk) begin
		tmp_din_int <= din;
		tmp_dir_int <= dir;
		tmp_load_int <= load;
		
		din_int <= tmp_din_int;
		dir_int <= tmp_dir_int;
		load_int <= tmp_load_int;
		
	end
	
	
	always @(posedge clk, negedge rst) begin
		if(!rst) 
			tmp_rst_int <= 1'b0;
		else
			tmp_rst_int <= 1'b1;
		
		rst_int <= tmp_rst_int;
	end

	
	lab4_1 #(
        .cmd(top_cmd)
    ) divider (
		.clk(clk),
		.ena(1'b1),
		.srst(rst_int),
		.cout(cmd_cout)
	);
	
	
	lab4_2 #(
		.cm(cmd_par)
	) counter (
		.clk(clk),   
		.ena(1), 
		.load(load_int),
		.din(din_int),   
		.dir(dir_int),   
		.arst(rst_int),      
		.q(tmp_q)         
	);
	
	assign q = ~tmp_q;
	
	
endmodule