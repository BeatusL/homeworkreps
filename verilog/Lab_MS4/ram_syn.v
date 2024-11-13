`timescale 1ns/1ns
module sp_ram // new data read during write
    #(parameter data_width = 8,
      parameter addr_width = 8,
      parameter init_value = 0)
     (input  [addr_width-1:0] addr,
      input  [data_width-1:0] data_in,
      input                   clk,
      input                   we,
      output  [data_width-1:0] data_out);

    reg [data_width-1:0] mem [0:(2**addr_width)-1];
    integer i;
    reg [addr_width-1:0] addr_r;
    initial
        for ( i =0 ;i<=(2**addr_width)-1 ; i=i+1 ) 
            mem[i] = init_value;    
    
    always @(posedge clk) begin 
        if (we == 1)
            mem[addr] <= data_in;
        addr_r <= addr;
    end
    assign data_out = mem[addr_r];
endmodule




