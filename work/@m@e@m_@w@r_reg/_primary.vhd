library verilog;
use verilog.vl_types.all;
entity MEM_WR_reg is
    port(
        alu_out         : out    vl_logic_vector(63 downto 0);
        data_mem_out    : out    vl_logic_vector(63 downto 0);
        rd_out          : out    vl_logic_vector(4 downto 0);
        MemToReg_out    : out    vl_logic;
        RegWrite_out    : out    vl_logic;
        alu_in          : in     vl_logic_vector(63 downto 0);
        data_mem_in     : in     vl_logic_vector(63 downto 0);
        rd_in           : in     vl_logic_vector(4 downto 0);
        MemToReg_in     : in     vl_logic;
        RegWrite_in     : in     vl_logic;
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        enable          : in     vl_logic
    );
end MEM_WR_reg;
