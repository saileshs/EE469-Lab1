library verilog;
use verilog.vl_types.all;
entity datamem is
    port(
        address         : in     vl_logic_vector(63 downto 0);
        write_enable    : in     vl_logic;
        read_enable     : in     vl_logic;
        write_data      : in     vl_logic_vector(63 downto 0);
        clk             : in     vl_logic;
        xfer_size       : in     vl_logic_vector(3 downto 0);
        read_data       : out    vl_logic_vector(63 downto 0)
    );
end datamem;
