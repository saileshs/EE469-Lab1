library verilog;
use verilog.vl_types.all;
entity controlUnit is
    generic(
        LDUR            : vl_logic_vector(31 downto 21) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0);
        STUR            : vl_logic_vector(31 downto 21) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        B               : vl_logic_vector(31 downto 21) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, HiZ, HiZ, HiZ, HiZ, HiZ);
        CBZ             : vl_logic_vector(31 downto 21) := (Hi1, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, HiZ, HiZ, HiZ);
        ADDI            : vl_logic_vector(31 downto 21) := (Hi1, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, HiZ);
        ADDS            : vl_logic_vector(31 downto 21) := (Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0);
        BL              : vl_logic_vector(31 downto 21) := (Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, HiZ, HiZ, HiZ, HiZ, HiZ);
        BR              : vl_logic_vector(31 downto 21) := (Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0);
        SUBS            : vl_logic_vector(31 downto 21) := (Hi1, Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0);
        BCOND           : vl_logic_vector(31 downto 21) := (Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, HiZ, HiZ, HiZ)
    );
    port(
        Reg2Loc         : out    vl_logic;
        ALUSrc          : out    vl_logic_vector(1 downto 0);
        MemToReg        : out    vl_logic;
        RegWrite        : out    vl_logic;
        MemWrite        : out    vl_logic;
        BrTaken         : out    vl_logic_vector(1 downto 0);
        UncondBr        : out    vl_logic;
        ALUOp           : out    vl_logic_vector(2 downto 0);
        X30Write        : out    vl_logic;
        SetFlag         : out    vl_logic;
        opCode          : in     vl_logic_vector(31 downto 21);
        negativeFlag    : in     vl_logic;
        zeroFlag        : in     vl_logic;
        overflowFlag    : in     vl_logic;
        DFF_negativeFlag: in     vl_logic;
        DFF_overflowFlag: in     vl_logic;
        IDEX_SetFlag    : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of LDUR : constant is 2;
    attribute mti_svvh_generic_type of STUR : constant is 2;
    attribute mti_svvh_generic_type of B : constant is 2;
    attribute mti_svvh_generic_type of CBZ : constant is 2;
    attribute mti_svvh_generic_type of ADDI : constant is 2;
    attribute mti_svvh_generic_type of ADDS : constant is 2;
    attribute mti_svvh_generic_type of BL : constant is 2;
    attribute mti_svvh_generic_type of BR : constant is 2;
    attribute mti_svvh_generic_type of SUBS : constant is 2;
    attribute mti_svvh_generic_type of BCOND : constant is 2;
end controlUnit;
