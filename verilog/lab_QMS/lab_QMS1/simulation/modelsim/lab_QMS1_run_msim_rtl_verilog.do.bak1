transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/repos/verilog/lab_QMS/lab_QMS1 {D:/repos/verilog/lab_QMS/lab_QMS1/cnt_adr.v}
vlog -vlog01compat -work work +incdir+D:/repos/verilog/lab_QMS/lab_QMS1 {D:/repos/verilog/lab_QMS/lab_QMS1/ROM_8D.v}
vlog -vlog01compat -work work +incdir+D:/repos/verilog/lab_QMS/lab_QMS1 {D:/repos/verilog/lab_QMS/lab_QMS1/DFF_chain.v}
vlog -vlog01compat -work work +incdir+D:/repos/verilog/lab_QMS/lab_QMS1 {D:/repos/verilog/lab_QMS/lab_QMS1/cnt_div.v}
vlog -vlog01compat -work work +incdir+D:/repos/verilog/lab_QMS/lab_QMS1 {D:/repos/verilog/lab_QMS/lab_QMS1/lab_QMS1.v}

vlog -vlog01compat -work work +incdir+D:/repos/verilog/lab_QMS/lab_QMS1 {D:/repos/verilog/lab_QMS/lab_QMS1/tb_lab_QMS1.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_lab_QMS1

add wave *
view structure
view signals
run -all
