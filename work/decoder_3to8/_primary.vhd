library verilog;
use verilog.vl_types.all;
entity decoder_3to8 is
    port(
        \out\           : out    vl_logic_vector(7 downto 0);
        \in\            : in     vl_logic_vector(2 downto 0);
        enable          : in     vl_logic
    );
end decoder_3to8;
