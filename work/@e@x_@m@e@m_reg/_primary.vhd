library verilog;
use verilog.vl_types.all;
entity EX_MEM_reg is
    port(
        data2_out       : out    vl_logic_vector(63 downto 0);
        alu_out         : out    vl_logic_vector(63 downto 0);
        EXMEM_RegisterRd: out    vl_logic_vector(4 downto 0);
        MemWrite_out    : out    vl_logic;
        MemToReg_out    : out    vl_logic;
        RegWrite_out    : out    vl_logic;
        BLCtrl_out      : out    vl_logic;
        X30Write_out    : out    vl_logic;
        data2_in        : in     vl_logic_vector(63 downto 0);
        rd_in           : in     vl_logic_vector(4 downto 0);
        alu_in          : in     vl_logic_vector(63 downto 0);
        MemWrite_in     : in     vl_logic;
        MemToReg_in     : in     vl_logic;
        RegWrite_in     : in     vl_logic;
        BLCtrl_in       : in     vl_logic;
        X30Write_in     : in     vl_logic;
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        enable          : in     vl_logic
    );
end EX_MEM_reg;
