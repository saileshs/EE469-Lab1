library verilog;
use verilog.vl_types.all;
entity DFF1_enable is
    port(
        q               : out    vl_logic;
        d               : in     vl_logic;
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        enable          : in     vl_logic
    );
end DFF1_enable;
