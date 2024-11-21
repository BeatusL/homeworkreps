module lab_QMS3 (
   input  CLK, aRSTin,
	input [7:0] Din,
   output reg PWM	
);

	reg [7:0] Dint;
	reg [7:0] Dcnt;
	reg arst, t_rst;
	wire t_cout, t_pwm;
	
	
	always @(posedge CLK or posedge aRSTin) begin
       if (aRSTin)
           t_rst <= 1'b1; 
       else
           t_rst <= 1'b0;
   end
	
	
	always @(posedge CLK or posedge aRSTin) begin
       if (aRSTin)
           arst <= 1'b1; 
       else
           arst <= t_rst;
   end
	
	
	always @(posedge CLK or posedge arst) begin
		if (arst)
			Dint <= 8'd128; 
		else if (t_cout)
			Dint <= Din; 
	end
	
	
	always @(posedge CLK or posedge arst) begin
       if (arst)
           PWM <= 1'b1; 
       else
           PWM <= t_pwm;
   end
	
	
	CNT CNT_inst (
		.clock(CLK),
		.aclr(arst),  
		.q(Dcnt),
		.cout(t_cout)
	);

	CMP CMP_inst (
		.dataa(Dint),
		.datab(Dcnt),  
		.alb(t_pwm)
	);
	
endmodule	