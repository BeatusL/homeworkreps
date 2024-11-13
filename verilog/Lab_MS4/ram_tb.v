`timescale 1ns/1ns
`define clk_pd 100

module ram_tb     
    #(parameter data_width = 12,
      parameter addr_width = 6)
    ();
    reg we_spram0;
    reg we_spram1;
    reg we_spram2;
    reg clk;
    reg [addr_width-1:0] addr;
    reg [data_width-1:0] data_in_spram0;    
    reg [data_width-1:0] data_in_spram1;
    reg [data_width-1:0] data_in_spram2;

    wire [data_width-1:0]  data_out_spram0;
    wire [data_width-1:0]  data_out_spram1;
    wire [data_width-1:0]  data_out_spram2;

    sp_ram #(.data_width(data_width), .addr_width(addr_width), .init_value (0)) spram0
        (.clk(clk),
         .we(we_spram0),
         .addr(addr),
         .data_in(data_in_spram0),
         .data_out(data_out_spram0));

    sp_ram #(.data_width(data_width), .addr_width(addr_width), .init_value (1)) spram1
        (.clk(clk),
         .we(we_spram1),
         .addr(addr),
         .data_in(data_in_spram1),
         .data_out(data_out_spram1));

    sp_ram #(.data_width(data_width), .addr_width(addr_width), .init_value (2)) spram2
        (.clk(clk),
         .we(we_spram2),
         .addr(addr),
         .data_in(data_in_spram2),
         .data_out(data_out_spram2));

    initial begin : init_
        we_spram0 = 0;
        we_spram1 = 0;
        we_spram2 = 0;
        data_in_spram0 = 2**data_width-1;
        data_in_spram1 = 2**data_width-1;
        data_in_spram2 = 2**data_width-1;
        addr = 0;
    end
    
    initial begin : clock_driver
        clk = 0;
        forever #(`clk_pd/2) clk = ~clk;
    end

    integer i;
    initial begin 
        @(negedge clk);
        @(negedge clk);
        we_spram0 = 1;
        for (i =0 ; i<=(2**addr_width)-1 ; i=i+1 )  
            begin
                data_in_spram0    = i;
                addr = i;
                @(negedge clk);
            end
        addr =0;
        we_spram0 = 0;    
        @(negedge clk);
        for (i =0 ; i<=(2**addr_width)-1 ; i=i+1 )  
            begin
                addr = i;
                @(negedge clk);
            end


        $display("### End of Simulation!");
        $stop;
    end
endmodule
