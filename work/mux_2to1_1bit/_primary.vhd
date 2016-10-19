library verilog;
use verilog.vl_types.all;
entity mux_2to1_1bit is
    port(
        \out\           : out    vl_logic;
        control         : in     vl_logic;
        \in\            : in     vl_logic_vector(1 downto 0)
    );
end mux_2to1_1bit;
