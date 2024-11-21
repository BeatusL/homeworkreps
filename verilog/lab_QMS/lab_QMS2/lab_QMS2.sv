module lab_QMS2 (
   input  CLK, aRSTin,     
   output reg [15:0] Dout	
);

    
   reg [7:0] cnt_q;
   reg [15:0] pwr_result;


   reg arst;
	reg t_rst;
	
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


   CNT CNT_inst (
       .clock(CLK),
       .aclr(arst),  
       .q(cnt_q)       
   );



   PWR PWR_inst (
       .dataa(cnt_q),       
       .datab(cnt_q),       
       .result(pwr_result)  
   );

    


   always @(posedge CLK or posedge arst) begin
       if (arst)
           Dout <= 16'h0; 
       else
           Dout <= pwr_result; 
   end

endmodule
