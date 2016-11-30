library verilog;
use verilog.vl_types.all;
entity DFF32 is
    port(
        q               : out    vl_logic_vector(31 downto 0);
        d               : in     vl_logic_vector(31 downto 0);
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        enable          : in     vl_logic
    );
end DFF32;
