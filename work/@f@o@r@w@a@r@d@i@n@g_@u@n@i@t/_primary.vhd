library verilog;
use verilog.vl_types.all;
entity FORWARDING_UNIT is
    port(
        forward_A       : out    vl_logic_vector(1 downto 0);
        forward_B       : out    vl_logic_vector(1 downto 0);
        rn_in           : in     vl_logic_vector(4 downto 0);
        rm_in           : in     vl_logic_vector(4 downto 0);
        IDEX_RegisterRd : in     vl_logic_vector(4 downto 0);
        EXMEM_RegisterRd: in     vl_logic_vector(4 downto 0);
        IDEX_RegWrite   : in     vl_logic;
        EXMEM_RegWrite  : in     vl_logic
    );
end FORWARDING_UNIT;
