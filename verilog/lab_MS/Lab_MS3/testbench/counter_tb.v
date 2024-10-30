`timescale 1ns / 1ns
module counter_tb #(parameter w=8);

reg clk, reset;
wire [w-1:0] count;

counter dut (clk, reset, count);

initial // Clock generator
  begin
    clk = 0;
    forever #10 clk = !clk;
  end
  
initial	// Test stimulus
  begin
    reset = 0;
    #5 reset = 1;
    #5 reset = 0;
  end
  
initial
    begin
        $monitor($stime,, reset,,, count);
        repeat (33) @( posedge clk);  
        $stop();
    end
endmodule  
