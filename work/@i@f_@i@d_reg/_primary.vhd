library verilog;
use verilog.vl_types.all;
entity IF_ID_reg is
    port(
        pc_out          : out    vl_logic_vector(63 downto 0);
        pc_plus4_out    : out    vl_logic_vector(63 downto 0);
        instr_out       : out    vl_logic_vector(31 downto 0);
        pc_in           : in     vl_logic_vector(63 downto 0);
        pc_plus4_in     : in     vl_logic_vector(63 downto 0);
        instr_in        : in     vl_logic_vector(31 downto 0);
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        enable          : in     vl_logic
    );
end IF_ID_reg;
