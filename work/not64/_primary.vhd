library verilog;
use verilog.vl_types.all;
entity not64 is
    port(
        \out\           : out    vl_logic_vector(63 downto 0);
        \in\            : in     vl_logic_vector(63 downto 0)
    );
end not64;
