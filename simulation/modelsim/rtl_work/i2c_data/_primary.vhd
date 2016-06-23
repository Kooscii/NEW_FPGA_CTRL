library verilog;
use verilog.vl_types.all;
entity i2c_data is
    generic(
        ENABLE          : vl_logic_vector(0 to 7) := (Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0);
        Single_Repeat   : vl_logic_vector(0 to 7) := (Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi1, Hi0);
        charging_en     : vl_logic_vector(0 to 7) := (Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1);
        Freq            : vl_logic_vector(0 to 7) := (Hi1, Hi0, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0);
        pw_0            : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1);
        pw_1            : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0);
        pw_2            : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1);
        pw_3            : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0);
        pw_4            : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1);
        pw_5            : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0);
        pd_0            : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi1);
        pd_1            : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0);
        pd_2            : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1);
        pd_3            : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0);
        pd_4            : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi1);
        pd_5            : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi1, Hi0);
        pwmd_0          : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1);
        pwmd_1          : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi1, Hi0);
        pwmd_2          : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi1, Hi1);
        pwmd_3          : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0);
        pwmd_4          : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1);
        pwmd_5          : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0)
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        rcv_succ        : in     vl_logic;
        command         : in     vl_logic_vector(7 downto 0);
        data            : in     vl_logic_vector(15 downto 0);
        enable_trigger  : out    vl_logic_vector(5 downto 0);
        enable_pwm      : out    vl_logic_vector(5 downto 0);
        multi_pulse     : out    vl_logic;
        frequency       : out    vl_logic_vector(15 downto 0);
        pulse_width_0   : out    vl_logic_vector(15 downto 0);
        pulse_delay_0   : out    vl_logic_vector(15 downto 0);
        pulse_width_1   : out    vl_logic_vector(15 downto 0);
        pulse_delay_1   : out    vl_logic_vector(15 downto 0);
        pulse_width_2   : out    vl_logic_vector(15 downto 0);
        pulse_delay_2   : out    vl_logic_vector(15 downto 0);
        pulse_width_3   : out    vl_logic_vector(15 downto 0);
        pulse_delay_3   : out    vl_logic_vector(15 downto 0);
        pulse_width_4   : out    vl_logic_vector(15 downto 0);
        pulse_delay_4   : out    vl_logic_vector(15 downto 0);
        pulse_width_5   : out    vl_logic_vector(15 downto 0);
        pulse_delay_5   : out    vl_logic_vector(15 downto 0);
        enable_charging : out    vl_logic;
        PWM_ctrol_0     : out    vl_logic_vector(15 downto 0);
        PWM_ctrol_1     : out    vl_logic_vector(15 downto 0);
        PWM_ctrol_2     : out    vl_logic_vector(15 downto 0);
        PWM_ctrol_3     : out    vl_logic_vector(15 downto 0);
        PWM_ctrol_4     : out    vl_logic_vector(15 downto 0);
        PWM_ctrol_5     : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ENABLE : constant is 1;
    attribute mti_svvh_generic_type of Single_Repeat : constant is 1;
    attribute mti_svvh_generic_type of charging_en : constant is 1;
    attribute mti_svvh_generic_type of Freq : constant is 1;
    attribute mti_svvh_generic_type of pw_0 : constant is 1;
    attribute mti_svvh_generic_type of pw_1 : constant is 1;
    attribute mti_svvh_generic_type of pw_2 : constant is 1;
    attribute mti_svvh_generic_type of pw_3 : constant is 1;
    attribute mti_svvh_generic_type of pw_4 : constant is 1;
    attribute mti_svvh_generic_type of pw_5 : constant is 1;
    attribute mti_svvh_generic_type of pd_0 : constant is 1;
    attribute mti_svvh_generic_type of pd_1 : constant is 1;
    attribute mti_svvh_generic_type of pd_2 : constant is 1;
    attribute mti_svvh_generic_type of pd_3 : constant is 1;
    attribute mti_svvh_generic_type of pd_4 : constant is 1;
    attribute mti_svvh_generic_type of pd_5 : constant is 1;
    attribute mti_svvh_generic_type of pwmd_0 : constant is 1;
    attribute mti_svvh_generic_type of pwmd_1 : constant is 1;
    attribute mti_svvh_generic_type of pwmd_2 : constant is 1;
    attribute mti_svvh_generic_type of pwmd_3 : constant is 1;
    attribute mti_svvh_generic_type of pwmd_4 : constant is 1;
    attribute mti_svvh_generic_type of pwmd_5 : constant is 1;
end i2c_data;
