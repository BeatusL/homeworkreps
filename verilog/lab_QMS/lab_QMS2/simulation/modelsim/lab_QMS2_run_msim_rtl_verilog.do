transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/repos/verilog/lab_QMS/lab_QMS2 {D:/repos/verilog/lab_QMS/lab_QMS2/CNT.v}
vlog -vlog01compat -work work +incdir+D:/repos/verilog/lab_QMS/lab_QMS2 {D:/repos/verilog/lab_QMS/lab_QMS2/PWR.v}
vlog -sv -work work +incdir+D:/repos/verilog/lab_QMS/lab_QMS2 {D:/repos/verilog/lab_QMS/lab_QMS2/lab_QMS2.sv}

vlog -sv -work work +incdir+D:/repos/verilog/lab_QMS/lab_QMS2 {D:/repos/verilog/lab_QMS/lab_QMS2/tb_lab_QMS2.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_lab_QMS2

add wave *
view structure
view signals
run -all
