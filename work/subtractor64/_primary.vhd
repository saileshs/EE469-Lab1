library verilog;
use verilog.vl_types.all;
entity subtractor64 is
    port(
        carryOut        : out    vl_logic;
        sum             : out    vl_logic_vector(63 downto 0);
        a               : in     vl_logic_vector(63 downto 0);
        b               : in     vl_logic_vector(63 downto 0)
    );
end subtractor64;
