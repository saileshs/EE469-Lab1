library verilog;
use verilog.vl_types.all;
entity xor64 is
    port(
        \out\           : out    vl_logic_vector(63 downto 0);
        a               : in     vl_logic_vector(63 downto 0);
        b               : in     vl_logic_vector(63 downto 0)
    );
end xor64;
