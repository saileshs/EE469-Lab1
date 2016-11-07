library verilog;
use verilog.vl_types.all;
entity shift_testbench is
    generic(
        delay           : integer := 20
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of delay : constant is 1;
end shift_testbench;
