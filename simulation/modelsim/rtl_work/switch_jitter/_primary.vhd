library verilog;
use verilog.vl_types.all;
entity switch_jitter is
    generic(
        IDEL            : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        RUN             : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        \WAIT\          : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        DONE            : vl_logic_vector(0 to 1) := (Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        switch_input    : in     vl_logic;
        switch_trigger  : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDEL : constant is 1;
    attribute mti_svvh_generic_type of RUN : constant is 1;
    attribute mti_svvh_generic_type of \WAIT\ : constant is 1;
    attribute mti_svvh_generic_type of DONE : constant is 1;
end switch_jitter;
