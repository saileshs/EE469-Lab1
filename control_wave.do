onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /controlUnit_testbench/negativeFlag
add wave -noupdate /controlUnit_testbench/zeroFlag
add wave -noupdate /controlUnit_testbench/overflowFlag
add wave -noupdate /controlUnit_testbench/Reg2Loc
add wave -noupdate /controlUnit_testbench/MemToReg
add wave -noupdate /controlUnit_testbench/RegWrite
add wave -noupdate /controlUnit_testbench/MemWrite
add wave -noupdate /controlUnit_testbench/UncondBr
add wave -noupdate /controlUnit_testbench/X30Write
add wave -noupdate /controlUnit_testbench/BLCtrl
add wave -noupdate /controlUnit_testbench/ALUSrc
add wave -noupdate /controlUnit_testbench/BrTaken
add wave -noupdate /controlUnit_testbench/ALUOp
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
WaveRestoreZoom {0 ps} {8949 ps}
