library verilog;
use verilog.vl_types.all;
entity addSub64 is
    port(
        carryOut        : out    vl_logic;
        result          : out    vl_logic_vector(63 downto 0);
        overflow        : out    vl_logic;
        a               : in     vl_logic_vector(63 downto 0);
        b               : in     vl_logic_vector(63 downto 0);
        carryIn         : in     vl_logic
    );
end addSub64;
