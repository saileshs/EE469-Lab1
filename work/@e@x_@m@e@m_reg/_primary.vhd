library verilog;
use verilog.vl_types.all;
entity EX_MEM_reg is
    port(
        branch_out      : out    vl_logic_vector(63 downto 0);
        data2_out       : out    vl_logic_vector(63 downto 0);
        alu_out         : out    vl_logic_vector(63 downto 0);
        MemWrite_out    : out    vl_logic;
        MemToReg_out    : out    vl_logic;
        RegWrite_out    : out    vl_logic;
        branch_in       : in     vl_logic_vector(63 downto 0);
        data2_in        : in     vl_logic_vector(63 downto 0);
        alu_in          : in     vl_logic_vector(63 downto 0);
        MemWrite_in     : in     vl_logic;
        MemToReg_in     : in     vl_logic;
        RegWrite_in     : in     vl_logic;
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        enable          : in     vl_logic
    );
end EX_MEM_reg;
