`timescale 1ns / 1ns

module counter #(parameter  w=8 ) 
(
  input clk, reset,
  output reg [w-1:0] count
);
always @ (posedge clk, posedge reset)
  if (reset)
     count <= {w{1'b0}};
  else
     count <= count + 1'b1;
endmodule
