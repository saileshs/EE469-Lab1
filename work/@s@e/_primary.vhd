library verilog;
use verilog.vl_types.all;
entity SE is
    generic(
        CBZ             : vl_logic_vector(0 to 10) := (Hi1, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, HiX, HiX, HiX);
        B               : vl_logic_vector(0 to 10) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, HiX, HiX, HiX, HiX, HiX);
        BL              : vl_logic_vector(0 to 10) := (Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, HiX, HiX, HiX, HiX, HiX);
        BLT             : vl_logic_vector(0 to 10) := (Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, HiX, HiX, HiX);
        LDUR            : vl_logic_vector(0 to 10) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0);
        STUR            : vl_logic_vector(0 to 10) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0)
    );
    port(
        \out\           : out    vl_logic_vector(63 downto 0);
        \in\            : in     vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CBZ : constant is 1;
    attribute mti_svvh_generic_type of B : constant is 1;
    attribute mti_svvh_generic_type of BL : constant is 1;
    attribute mti_svvh_generic_type of BLT : constant is 1;
    attribute mti_svvh_generic_type of LDUR : constant is 1;
    attribute mti_svvh_generic_type of STUR : constant is 1;
end SE;
