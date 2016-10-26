library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        A               : in     vl_logic_vector(63 downto 0);
        B               : in     vl_logic_vector(63 downto 0);
        cntrl           : in     vl_logic_vector(2 downto 0);
        result          : out    vl_logic_vector(63 downto 0);
        negative        : out    vl_logic;
        zero            : out    vl_logic;
        overflow        : out    vl_logic;
        carry_out       : out    vl_logic
    );
end alu;
