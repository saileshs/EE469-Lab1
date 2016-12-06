onerror {resume}
quietly WaveActivateNextPane {} 0
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
add wave -noupdate /cpu_pipelined_testbench/dut/clk
add wave -noupdate -expand -group {Forwarding Muxes} /cpu_pipelined_testbench/dut/forward/forward_A
add wave -noupdate -expand -group {Forwarding Muxes} /cpu_pipelined_testbench/dut/forward/forward_B
add wave -noupdate -expand -group {Forwarding Muxes} -label Forwarding_A_in -radix decimal /cpu_pipelined_testbench/dut/forwarding_mux1/in
add wave -noupdate -expand -group {Forwarding Muxes} -label Forwarding_B_in -radix decimal /cpu_pipelined_testbench/dut/forwarding_mux2/in
add wave -noupdate -expand -group {Forwarding Muxes} -label Forwarding_A_out -radix decimal /cpu_pipelined_testbench/dut/forwarding_mux1/out
add wave -noupdate -expand -group {Forwarding Muxes} -label Forwarding_B_out -radix decimal /cpu_pipelined_testbench/dut/forwarding_mux2/out
add wave -noupdate -label IDEX_data1_in -radix decimal /cpu_pipelined_testbench/dut/reg2/read_data1_in
add wave -noupdate -label IDEX_data2_in -radix decimal /cpu_pipelined_testbench/dut/reg2/read_data2_in
add wave -noupdate -label IDEX_data1_out -radix decimal /cpu_pipelined_testbench/dut/reg2/read_data1_out
add wave -noupdate -label IDEX_data2_out -radix decimal /cpu_pipelined_testbench/dut/reg2/read_data2_out
add wave -noupdate -expand -group ALU /cpu_pipelined_testbench/dut/a/negative
add wave -noupdate -expand -group ALU /cpu_pipelined_testbench/dut/a/zero
add wave -noupdate -expand -group ALU /cpu_pipelined_testbench/dut/a/overflow
add wave -noupdate -expand -group ALU /cpu_pipelined_testbench/dut/a/carry_out
add wave -noupdate -expand -group ALU -radix decimal /cpu_pipelined_testbench/dut/a/A
add wave -noupdate -expand -group ALU -radix decimal /cpu_pipelined_testbench/dut/a/B
add wave -noupdate -expand -group ALU -radix decimal /cpu_pipelined_testbench/dut/a/result
add wave -noupdate -expand -group ALU /cpu_pipelined_testbench/dut/a/cntrl
add wave -noupdate -expand -group ALU /cpu_pipelined_testbench/dut/a/addsub_out
add wave -noupdate -expand -group ALU /cpu_pipelined_testbench/dut/a/and_out
add wave -noupdate -expand -group ALU /cpu_pipelined_testbench/dut/a/or_out
add wave -noupdate -expand -group ALU /cpu_pipelined_testbench/dut/a/xor_out
add wave -noupdate -expand -group ALU /cpu_pipelined_testbench/dut/a/less_than_out
add wave -noupdate -expand -group ALU /cpu_pipelined_testbench/dut/a/alu_input
add wave -noupdate -group RegFile -radix unsigned /cpu_pipelined_testbench/dut/rf/ReadData1
add wave -noupdate -group RegFile -radix unsigned /cpu_pipelined_testbench/dut/rf/ReadData2
add wave -noupdate -group RegFile -radix unsigned /cpu_pipelined_testbench/dut/rf/ReadRegister1
add wave -noupdate -group RegFile -radix unsigned /cpu_pipelined_testbench/dut/rf/ReadRegister2
add wave -noupdate -group RegFile -radix unsigned /cpu_pipelined_testbench/dut/rf/WriteRegister
add wave -noupdate -group RegFile -radix unsigned /cpu_pipelined_testbench/dut/rf/WriteData
add wave -noupdate -group RegFile -radix unsigned /cpu_pipelined_testbench/dut/rf/RegWrite
add wave -noupdate -group RegFile -radix unsigned /cpu_pipelined_testbench/dut/rf/clk
add wave -noupdate -group RegFile -radix unsigned /cpu_pipelined_testbench/dut/rf/registerOutput
add wave -noupdate -group RegFile -radix unsigned /cpu_pipelined_testbench/dut/rf/enableRegister
add wave -noupdate -group RegFile -radix unsigned /cpu_pipelined_testbench/dut/rf/reset
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {572545972 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 238
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
WaveRestoreZoom {0 ps} {1295226221 ps}
