library verilog;
use verilog.vl_types.all;
entity emc is
    port(
        clk             : in     vl_logic;
        rstn            : out    vl_logic
    );
end emc;
