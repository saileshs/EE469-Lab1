library verilog;
use verilog.vl_types.all;
entity alustim is
    generic(
        delay           : integer := 100000;
        ALU_PASS_B      : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi0);
        ALU_ADD         : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi0);
        ALU_SUBTRACT    : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi1);
        ALU_AND         : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi0);
        ALU_OR          : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi1);
        ALU_XOR         : vl_logic_vector(0 to 2) := (Hi1, Hi1, Hi0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of delay : constant is 1;
    attribute mti_svvh_generic_type of ALU_PASS_B : constant is 1;
    attribute mti_svvh_generic_type of ALU_ADD : constant is 1;
    attribute mti_svvh_generic_type of ALU_SUBTRACT : constant is 1;
    attribute mti_svvh_generic_type of ALU_AND : constant is 1;
    attribute mti_svvh_generic_type of ALU_OR : constant is 1;
    attribute mti_svvh_generic_type of ALU_XOR : constant is 1;
end alustim;
