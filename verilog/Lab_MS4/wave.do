onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ram_tb/we_spram0
add wave -noupdate /ram_tb/we_spram1
add wave -noupdate /ram_tb/we_spram2
add wave -noupdate /ram_tb/clk
add wave -noupdate -radix unsigned /ram_tb/addr
add wave -noupdate -radix unsigned /ram_tb/data_in_spram0
add wave -noupdate -radix unsigned /ram_tb/data_in_spram1
add wave -noupdate -radix unsigned /ram_tb/data_in_spram2
add wave -noupdate -format Analog-Step -height 74 -max 63.0 -radix unsigned -childformat {{{/ram_tb/data_out_spram0[11]} -radix unsigned} {{/ram_tb/data_out_spram0[10]} -radix unsigned} {{/ram_tb/data_out_spram0[9]} -radix unsigned} {{/ram_tb/data_out_spram0[8]} -radix unsigned} {{/ram_tb/data_out_spram0[7]} -radix unsigned} {{/ram_tb/data_out_spram0[6]} -radix unsigned} {{/ram_tb/data_out_spram0[5]} -radix unsigned} {{/ram_tb/data_out_spram0[4]} -radix unsigned} {{/ram_tb/data_out_spram0[3]} -radix unsigned} {{/ram_tb/data_out_spram0[2]} -radix unsigned} {{/ram_tb/data_out_spram0[1]} -radix unsigned} {{/ram_tb/data_out_spram0[0]} -radix unsigned}} -subitemconfig {{/ram_tb/data_out_spram0[11]} {-height 15 -radix unsigned} {/ram_tb/data_out_spram0[10]} {-height 15 -radix unsigned} {/ram_tb/data_out_spram0[9]} {-height 15 -radix unsigned} {/ram_tb/data_out_spram0[8]} {-height 15 -radix unsigned} {/ram_tb/data_out_spram0[7]} {-height 15 -radix unsigned} {/ram_tb/data_out_spram0[6]} {-height 15 -radix unsigned} {/ram_tb/data_out_spram0[5]} {-height 15 -radix unsigned} {/ram_tb/data_out_spram0[4]} {-height 15 -radix unsigned} {/ram_tb/data_out_spram0[3]} {-height 15 -radix unsigned} {/ram_tb/data_out_spram0[2]} {-height 15 -radix unsigned} {/ram_tb/data_out_spram0[1]} {-height 15 -radix unsigned} {/ram_tb/data_out_spram0[0]} {-height 15 -radix unsigned}} /ram_tb/data_out_spram0
add wave -noupdate -format Analog-Step -height 74 -max 63.0 -radix unsigned /ram_tb/data_out_spram1
add wave -noupdate -format Analog-Step -height 74 -max 72.0 -min 2.0 -radix unsigned /ram_tb/data_out_spram2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {550 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 255
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
WaveRestoreZoom {0 ns} {13755 ns}
