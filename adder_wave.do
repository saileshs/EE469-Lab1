onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /adder_testbench/a
add wave -noupdate -radix unsigned /adder_testbench/b
add wave -noupdate -radix unsigned /adder_testbench/sum
add wave -noupdate /adder_testbench/cO
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3192 ps} 0}
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
WaveRestoreZoom {0 ps} {7614 ps}
