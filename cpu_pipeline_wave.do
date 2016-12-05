onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpu_pipelined_testbench/dut/clk
add wave -noupdate /cpu_pipelined_testbench/dut/program_counter/out
add wave -noupdate /cpu_pipelined_testbench/dut/instruction_memory/instruction
add wave -noupdate -radix decimal /cpu_pipelined_testbench/dut/instruction_memory/address
add wave -noupdate -radix unsigned /cpu_pipelined_testbench/dut/rf/ReadRegister1
add wave -noupdate -radix unsigned /cpu_pipelined_testbench/dut/rf/ReadRegister2
add wave -noupdate -radix unsigned /cpu_pipelined_testbench/dut/rf/WriteRegister
add wave -noupdate -radix decimal /cpu_pipelined_testbench/dut/rf/ReadData1
add wave -noupdate -radix decimal /cpu_pipelined_testbench/dut/rf/ReadData2
add wave -noupdate -radix decimal /cpu_pipelined_testbench/dut/rf/WriteData
add wave -noupdate -radix decimal /cpu_pipelined_testbench/dut/a/A
add wave -noupdate -radix decimal /cpu_pipelined_testbench/dut/a/B
add wave -noupdate -radix decimal /cpu_pipelined_testbench/dut/a/result
add wave -noupdate -childformat {{{/cpu_pipelined_testbench/dut/rf/registerOutput[31]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[30]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[29]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[28]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[27]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[26]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[25]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[24]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[23]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[22]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[21]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[20]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[19]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[18]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[17]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[16]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[15]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[14]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[13]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[12]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[11]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[10]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[9]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[8]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[7]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[6]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[5]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[4]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[3]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[2]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[1]} -radix decimal} {{/cpu_pipelined_testbench/dut/rf/registerOutput[0]} -radix decimal}} -subitemconfig {{/cpu_pipelined_testbench/dut/rf/registerOutput[31]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[30]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[29]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[28]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[27]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[26]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[25]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[24]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[23]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[22]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[21]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[20]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[19]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[18]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[17]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[16]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[15]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[14]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[13]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[12]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[11]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[10]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[9]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[8]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[7]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[6]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[5]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[4]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[3]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[2]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[1]} {-height 15 -radix decimal} {/cpu_pipelined_testbench/dut/rf/registerOutput[0]} {-height 15 -radix decimal}} /cpu_pipelined_testbench/dut/rf/registerOutput
add wave -noupdate /cpu_pipelined_testbench/dut/forward/forward_A
add wave -noupdate /cpu_pipelined_testbench/dut/forward/forward_B
add wave -noupdate -label Forwarding_A_out -radix decimal /cpu_pipelined_testbench/dut/forwarding_mux1/out
add wave -noupdate -label Forwarding_B_out -radix decimal /cpu_pipelined_testbench/dut/forwarding_mux2/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {254464877 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 207
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
WaveRestoreZoom {9212042466 ps} {10199366187 ps}
