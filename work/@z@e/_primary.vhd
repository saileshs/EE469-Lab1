library verilog;
use verilog.vl_types.all;
entity ZE is
    port(
        \out\           : out    vl_logic_vector(63 downto 0);
        \in\            : in     vl_logic_vector(11 downto 0)
    );
end ZE;
