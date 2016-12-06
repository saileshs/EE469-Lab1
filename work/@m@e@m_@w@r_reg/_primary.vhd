library verilog;
use verilog.vl_types.all;
entity MEM_WR_reg is
    port(
        pc_plus4_out    : out    vl_logic_vector(63 downto 0);
        data_out        : out    vl_logic_vector(63 downto 0);
        MEMWR_RegisterRd: out    vl_logic_vector(4 downto 0);
        RegWrite_out    : out    vl_logic;
        X30Write_out    : out    vl_logic;
        pc_plus4_in     : in     vl_logic_vector(63 downto 0);
        data_in         : in     vl_logic_vector(63 downto 0);
        EXMEM_RegisterRd: in     vl_logic_vector(4 downto 0);
        RegWrite_in     : in     vl_logic;
        X30Write_in     : in     vl_logic;
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        enable          : in     vl_logic
    );
end MEM_WR_reg;
