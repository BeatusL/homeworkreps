`timescale 1ns/1ps
module tb_lab_QMS3;
   localparam CLK_PERIOD = 40; 
   reg CLK;                    
   reg aRSTin;
	reg [7:0] Din;
   wire PWM;          


   integer i;
    
   lab_QMS3 DUT (
      .CLK(CLK),
      .aRSTin(aRSTin),
		.Din(Din),
      .PWM(PWM)
   );

   always #(CLK_PERIOD / 2) CLK = ~CLK;
	
	initial begin
      CLK = 0;
   end

   initial begin
       aRSTin = 1;
       #(2 * CLK_PERIOD); 
       aRSTin = 0;
		 Din = 16;
		 #(CLK_PERIOD * 768);
       for (i = 0; i < 512 * 3; i++) begin  
         $display("CNT: %d | PWM: %h", i % 256, PWM);
       end
		 Din = 32;
		 #(CLK_PERIOD * 768);
		 Din = 128;
		 #(CLK_PERIOD * 768);
		 #1000 $stop;
	end

endmodule
