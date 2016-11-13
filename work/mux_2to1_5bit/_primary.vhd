library verilog;
use verilog.vl_types.all;
entity mux_2to1_5bit is
    port(
        \out\           : out    vl_logic_vector(4 downto 0);
        control         : in     vl_logic;
        \in\            : in     vl_logic
    );
end mux_2to1_5bit;
