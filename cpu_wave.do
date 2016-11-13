onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpu_testbench/dut/address
add wave -noupdate /cpu_testbench/dut/instruction_memory/instruction
add wave -noupdate /cpu_testbench/dut/control/opCode
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {343277 ps} {350354 ps}
