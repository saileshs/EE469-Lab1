library verilog;
use verilog.vl_types.all;
entity DFF4 is
    port(
        q               : out    vl_logic_vector(3 downto 0);
        d               : in     vl_logic_vector(3 downto 0);
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        enable          : in     vl_logic
    );
end DFF4;
