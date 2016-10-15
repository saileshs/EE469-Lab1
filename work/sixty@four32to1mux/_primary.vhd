library verilog;
use verilog.vl_types.all;
entity sixtyFour32to1mux is
    port(
        \out\           : out    vl_logic_vector(63 downto 0);
        readReg         : in     vl_logic_vector(4 downto 0);
        \in\            : in     vl_logic
    );
end sixtyFour32to1mux;
