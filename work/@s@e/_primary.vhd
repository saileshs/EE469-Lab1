library verilog;
use verilog.vl_types.all;
entity SE is
    port(
        \out\           : out    vl_logic_vector(63 downto 0);
        \in\            : in     vl_logic_vector(31 downto 0)
    );
end SE;
