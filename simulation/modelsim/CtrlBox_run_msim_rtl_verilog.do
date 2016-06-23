transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/shiha/Desktop/New\ FPGA\ ctrl {C:/Users/shiha/Desktop/New FPGA ctrl/switch_jitter.v}
vlog -vlog01compat -work work +incdir+C:/Users/shiha/Desktop/New\ FPGA\ ctrl {C:/Users/shiha/Desktop/New FPGA ctrl/i2c_data.v}
vlog -vlog01compat -work work +incdir+C:/Users/shiha/Desktop/New\ FPGA\ ctrl {C:/Users/shiha/Desktop/New FPGA ctrl/emc.v}
vlog -vlog01compat -work work +incdir+C:/Users/shiha/Desktop/New\ FPGA\ ctrl {C:/Users/shiha/Desktop/New FPGA ctrl/CtrlBox.v}
vlog -vlog01compat -work work +incdir+C:/Users/shiha/Desktop/New\ FPGA\ ctrl {C:/Users/shiha/Desktop/New FPGA ctrl/trigger_singal_generator.v}
vlog -vlog01compat -work work +incdir+C:/Users/shiha/Desktop/New\ FPGA\ ctrl {C:/Users/shiha/Desktop/New FPGA ctrl/RTC.v}
vlog -vlog01compat -work work +incdir+C:/Users/shiha/Desktop/New\ FPGA\ ctrl {C:/Users/shiha/Desktop/New FPGA ctrl/pulse_generation.v}
vlog -vlog01compat -work work +incdir+C:/Users/shiha/Desktop/New\ FPGA\ ctrl {C:/Users/shiha/Desktop/New FPGA ctrl/i2c_slave.v}
vlog -vlog01compat -work work +incdir+C:/Users/shiha/Desktop/New\ FPGA\ ctrl {C:/Users/shiha/Desktop/New FPGA ctrl/PWM_generation.v}

