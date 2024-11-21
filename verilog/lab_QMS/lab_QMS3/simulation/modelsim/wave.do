onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_lab_QMS3/CLK
add wave -noupdate -radix unsigned /tb_lab_QMS3/aRSTin
add wave -noupdate -radix unsigned /tb_lab_QMS3/DUT/Dcnt
add wave -noupdate -radix unsigned /tb_lab_QMS3/Din
add wave -noupdate -radix unsigned /tb_lab_QMS3/DUT/Dint
add wave -noupdate -radix unsigned /tb_lab_QMS3/DUT/t_cout
add wave -noupdate -radix unsigned /tb_lab_QMS3/PWM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {21556764 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 214
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {22638 ns}
