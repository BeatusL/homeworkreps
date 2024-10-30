onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /counter_tb/dut/clk
add wave -noupdate /counter_tb/dut/reset
add wave -noupdate -max 32.0 -radix unsigned /counter_tb/dut/count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {A {228 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 50
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {158 ns} {694 ns}
