library verilog;
use verilog.vl_types.all;
entity or_multi is
    generic(
        WIDTH           : integer := 64
    );
    port(
        \out\           : out    vl_logic_vector;
        \in\            : in     vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end or_multi;
