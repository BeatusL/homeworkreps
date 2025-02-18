`timescale 1ns/1ps
module tb_lab_QMS2;
   localparam CLK_PERIOD = 40; 
   reg CLK;                    
   reg aRSTin;                
   wire [15:0] Dout;          


   integer i;
    
   lab_QMS2 DUT (
      .CLK(CLK),
      .aRSTin(aRSTin),
      .Dout(Dout)
   );

   always #(CLK_PERIOD / 2) CLK = ~CLK;
	
	initial begin
      CLK = 0;
   end

   initial begin
       aRSTin = 1;
       #(2 * CLK_PERIOD); 
       aRSTin = 0;

       for (i = 0; i < 512; i++) begin 
			#(CLK_PERIOD); 
         $display("CNT: %d | Dout: %h", i % 256, Dout);
       end

		 #1000 $stop;
	end

endmodule
