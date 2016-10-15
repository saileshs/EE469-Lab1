onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /mux_testbench/out
add wave -noupdate -radix unsigned -childformat {{{/mux_testbench/in[1]} -radix unsigned} {{/mux_testbench/in[0]} -radix unsigned}} -expand -subitemconfig {{/mux_testbench/in[1]} {-radix unsigned} {/mux_testbench/in[0]} {-radix unsigned}} /mux_testbench/in
add wave -noupdate /mux_testbench/control
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1116125 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 100
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {663600 ps} {1175600 ps}
