library verilog;
use verilog.vl_types.all;
entity ID_EX_reg is
    port(
        pc_plus4_out    : out    vl_logic_vector(63 downto 0);
        rd_out          : out    vl_logic_vector(4 downto 0);
        se_imm12_out    : out    vl_logic_vector(63 downto 0);
        se_imm9_out     : out    vl_logic_vector(63 downto 0);
        read_data1_out  : out    vl_logic_vector(63 downto 0);
        read_data2_out  : out    vl_logic_vector(63 downto 0);
        ALUSrc_out      : out    vl_logic_vector(1 downto 0);
        ALUOp_out       : out    vl_logic_vector(2 downto 0);
        MemWrite_out    : out    vl_logic;
        MemToReg_out    : out    vl_logic;
        RegWrite_out    : out    vl_logic;
        SetFlag_out     : out    vl_logic;
        pc_plus4_in     : in     vl_logic_vector(63 downto 0);
        rd_in           : in     vl_logic_vector(4 downto 0);
        se_imm12_in     : in     vl_logic_vector(63 downto 0);
        se_imm9_in      : in     vl_logic_vector(63 downto 0);
        read_data1_in   : in     vl_logic_vector(63 downto 0);
        read_data2_in   : in     vl_logic_vector(63 downto 0);
        ALUSrc_in       : in     vl_logic_vector(1 downto 0);
        ALUOp_in        : in     vl_logic_vector(2 downto 0);
        MemWrite_in     : in     vl_logic;
        MemToReg_in     : in     vl_logic;
        RegWrite_in     : in     vl_logic;
        SetFlag_in      : in     vl_logic;
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        enable          : in     vl_logic
    );
end ID_EX_reg;
