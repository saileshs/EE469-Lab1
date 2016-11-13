onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpu_testbench/dut/control/opCode
add wave -noupdate /cpu_testbench/dut/instruction_memory/address
add wave -noupdate /cpu_testbench/dut/instruction_memory/instruction
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {0 ps} 0}
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
WaveRestoreZoom {49999543951 ps} {50000449679 ps}
