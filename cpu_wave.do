onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpu_testbench/dut/opCode
add wave -noupdate -radix decimal /cpu_testbench/dut/instruction_memory/address
add wave -noupdate /cpu_testbench/dut/instruction_memory/instruction
add wave -noupdate -radix unsigned /cpu_testbench/dut/Rd
add wave -noupdate -radix unsigned /cpu_testbench/dut/Rm
add wave -noupdate -radix unsigned /cpu_testbench/dut/Rn
add wave -noupdate /cpu_testbench/dut/ReadRegister
add wave -noupdate /cpu_testbench/dut/ReadData1
add wave -noupdate /cpu_testbench/dut/ReadData2
add wave -noupdate -radix unsigned /cpu_testbench/dut/rf/WriteRegister
add wave -noupdate -radix decimal /cpu_testbench/dut/rf/WriteData
add wave -noupdate -childformat {{{/cpu_testbench/dut/rf/registerOutput[31]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[30]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[29]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[28]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[27]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[26]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[25]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[24]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[23]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[22]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[21]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[20]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[19]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[18]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[17]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[16]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[15]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[14]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[13]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[12]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[11]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[10]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[9]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[8]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[7]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[6]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[5]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[4]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[3]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[2]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[1]} -radix decimal} {{/cpu_testbench/dut/rf/registerOutput[0]} -radix decimal}} -subitemconfig {{/cpu_testbench/dut/rf/registerOutput[31]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[30]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[29]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[28]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[27]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[26]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[25]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[24]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[23]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[22]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[21]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[20]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[19]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[18]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[17]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[16]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[15]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[14]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[13]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[12]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[11]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[10]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[9]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[8]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[7]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[6]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[5]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[4]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[3]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[2]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[1]} {-height 15 -radix decimal} {/cpu_testbench/dut/rf/registerOutput[0]} {-height 15 -radix decimal}} /cpu_testbench/dut/rf/registerOutput
add wave -noupdate /cpu_testbench/dut/negativeFlag
add wave -noupdate /cpu_testbench/dut/zeroFlag
add wave -noupdate /cpu_testbench/dut/overflowFlag
add wave -noupdate /cpu_testbench/dut/carryOutFlag
add wave -noupdate /cpu_testbench/dut/SetFlag
add wave -noupdate /cpu_testbench/dut/control/Reg2Loc
add wave -noupdate /cpu_testbench/dut/control/MemToReg
add wave -noupdate /cpu_testbench/dut/control/RegWrite
add wave -noupdate /cpu_testbench/dut/control/MemWrite
add wave -noupdate /cpu_testbench/dut/control/UncondBr
add wave -noupdate /cpu_testbench/dut/control/X30Write
add wave -noupdate /cpu_testbench/dut/control/BLCtrl
add wave -noupdate /cpu_testbench/dut/control/ALUSrc
add wave -noupdate /cpu_testbench/dut/control/BrTaken
add wave -noupdate /cpu_testbench/dut/control/ALUOp
add wave -noupdate /cpu_testbench/dut/control/BLTLogic
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {842838801 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 210
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
WaveRestoreZoom {658710940 ps} {1317421880 ps}
