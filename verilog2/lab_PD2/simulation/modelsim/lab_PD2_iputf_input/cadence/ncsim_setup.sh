

ncvlog     "D:/repos/verilog2/lab_PD2/lab_PD2/simulation/submodules/altera_avalon_sc_fifo.v" -work sc_fifo     -cdslib <<sc_fifo>>    
ncvlog -sv "D:/repos/verilog2/lab_PD2/lab_PD2/simulation/submodules/MyST_source.sv"          -work MyST_source -cdslib <<MyST_source>>
ncvlog -sv "D:/repos/verilog2/lab_PD2/lab_PD2/simulation/submodules/MyST_sink.sv"            -work MyST_sink   -cdslib <<MyST_sink>>  
ncvlog     "D:/repos/verilog2/lab_PD2/lab_PD2/simulation/lab_PD2.v"                                                                   
