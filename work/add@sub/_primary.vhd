library verilog;
use verilog.vl_types.all;
entity addSub is
    port(
        carryOut        : out    vl_logic;
        sum             : out    vl_logic;
        a               : in     vl_logic;
        b               : in     vl_logic;
        carryIn         : in     vl_logic
    );
end addSub;
