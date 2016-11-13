# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./regfile.sv"
vlog "./testbench.sv"
vlog "./decoder.sv"
vlog "./muxes.sv"
vlog "./alustim.sv"
vlog "./adder.sv"
vlog "./logicalOps.sv"
vlog "./alu.sv"
vlog "./zeroExtend.sv"
vlog "./signExtend.sv"
vlog "./shifter.sv"
vlog "./programCounter.sv"
vlog "./instructmem.sv"
vlog "./datamem.sv"
vlog "./cpu.sv"
vlog "./controlUnit.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work cpu_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do cpu_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
