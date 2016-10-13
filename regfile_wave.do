onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /regstim/dut/clk
add wave -noupdate -radix unsigned /regstim/WriteRegister
add wave -noupdate -radix unsigned /regstim/dut/ReadRegister1
add wave -noupdate -radix unsigned /regstim/dut/ReadRegister2
add wave -noupdate -radix unsigned /regstim/dut/WriteData
add wave -noupdate -radix unsigned /regstim/dut/RegWrite
add wave -noupdate /regstim/ReadData1
add wave -noupdate /regstim/ReadData2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {473658801 ps} 0}
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
WaveRestoreZoom {446370400 ps} {479138400 ps}
