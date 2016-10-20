onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /adder_testbench/a
add wave -noupdate -radix binary /adder_testbench/b
add wave -noupdate /adder_testbench/carryOut
add wave -noupdate /adder_testbench/overflow
add wave -noupdate /adder_testbench/result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8050 ps} 0}
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
WaveRestoreZoom {867 ps} {8481 ps}
