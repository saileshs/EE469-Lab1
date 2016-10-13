library verilog;
use verilog.vl_types.all;
entity mux_16to1 is
    port(
        \out\           : out    vl_logic_vector(63 downto 0);
        control         : in     vl_logic_vector(3 downto 0);
        \in\            : in     vl_logic
    );
end mux_16to1;
