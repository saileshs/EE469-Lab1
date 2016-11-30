library verilog;
use verilog.vl_types.all;
entity cpu_pipelined is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic
    );
end cpu_pipelined;
