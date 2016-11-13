library verilog;
use verilog.vl_types.all;
entity instructmem is
    port(
        address         : in     vl_logic_vector(63 downto 0);
        instruction     : out    vl_logic_vector(31 downto 0);
        clk             : in     vl_logic
    );
end instructmem;
