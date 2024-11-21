transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/repos/verilog/lab_QMS/lab_QMS3 {D:/repos/verilog/lab_QMS/lab_QMS3/CNT.v}
vlog -vlog01compat -work work +incdir+D:/repos/verilog/lab_QMS/lab_QMS3 {D:/repos/verilog/lab_QMS/lab_QMS3/CMP.v}
vlog -sv -work work +incdir+D:/repos/verilog/lab_QMS/lab_QMS3 {D:/repos/verilog/lab_QMS/lab_QMS3/lab_QMS3.sv}

vlog -sv -work work +incdir+D:/repos/verilog/lab_QMS/lab_QMS3 {D:/repos/verilog/lab_QMS/lab_QMS3/tb_lab_QMS3.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_lab_QMS3

add wave *
view structure
view signals
run -all
