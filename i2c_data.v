module i2c_data(
	clk,
	rst,
	
	rcv_succ,
	command,
	data,
	
	enable_trigger,
	enable_pwm,
	
	multi_pulse,
	frequency,
	pulse_width_0,	pulse_delay_0,
	pulse_width_1,	pulse_delay_1,
	pulse_width_2,	pulse_delay_2,
	pulse_width_3,	pulse_delay_3,
	pulse_width_4,	pulse_delay_4,
	pulse_width_5,	pulse_delay_5,
	
	enable_charging,
	
	PWM_ctrol_0, PWM_ctrol_1, PWM_ctrol_2,
	PWM_ctrol_3, PWM_ctrol_4, PWM_ctrol_5
);

input clk, rst;
input rcv_succ;
input[7:0] command;
input[15:0] data;
output[5:0] enable_trigger, enable_pwm;
output multi_pulse;
output[15:0] frequency;
output[15:0] pulse_width_0,	pulse_delay_0;
output[15:0] pulse_width_1,	pulse_delay_1;
output[15:0] pulse_width_2,	pulse_delay_2;
output[15:0] pulse_width_3,	pulse_delay_3;
output[15:0] pulse_width_4,	pulse_delay_4;
output[15:0] pulse_width_5,	pulse_delay_5;
output enable_charging;
output[15:0] PWM_ctrol_0, PWM_ctrol_1, PWM_ctrol_2, PWM_ctrol_3, PWM_ctrol_4, PWM_ctrol_5;

//command PARAMETER
parameter ENABLE = 8'hA0;	//使能命令
parameter Single_Repeat = 8'hA2;	//单次或者重频
parameter charging_en = 8'hA1;	//充电使能
parameter Freq = 8'hB2;	//频率
parameter pw_0 = 8'hC1;	//脉冲0脉宽
parameter pw_1 = 8'hC2;	//脉冲1脉宽
parameter pw_2 = 8'hC3;	//脉冲2脉宽
parameter pw_3 = 8'hC4;	//脉冲3脉宽
parameter pw_4 = 8'hC5;	//脉冲4脉宽
parameter pw_5 = 8'hC6;	//脉冲5脉宽
parameter pd_0 = 8'hD1;	//脉冲0延时
parameter pd_1 = 8'hD2;	//脉冲1延时
parameter pd_2 = 8'hD3;	//脉冲2延时
parameter pd_3 = 8'hD4;	//脉冲3延时
parameter pd_4 = 8'hD5;	//脉冲4延时
parameter pd_5 = 8'hD6;	//脉冲5延时
parameter pwmd_0 = 8'hE1;	//PWM0数据
parameter pwmd_1 = 8'hE2;	//PWM1数据
parameter pwmd_2 = 8'hE3;	//PWM2数据
parameter pwmd_3 = 8'hE4;	//PWM3数据
parameter pwmd_4 = 8'hE5;	//PWM4数据
parameter pwmd_5 = 8'hE6;	//PWM5数据

reg[5:0] enable_trigger_r, enable_pwm_r;
reg multi_pulse_r;
reg[15:0] frequency_r;
reg[15:0] pulse_width_0_r,	pulse_delay_0_r;
reg[15:0] pulse_width_1_r,	pulse_delay_1_r;
reg[15:0] pulse_width_2_r,	pulse_delay_2_r;
reg[15:0] pulse_width_3_r,	pulse_delay_3_r;
reg[15:0] pulse_width_4_r,	pulse_delay_4_r;
reg[15:0] pulse_width_5_r,	pulse_delay_5_r;
reg[15:0] PWM_ctrol_0_r, PWM_ctrol_1_r, PWM_ctrol_2_r, PWM_ctrol_3_r, PWM_ctrol_4_r, PWM_ctrol_5_r;
reg enable_charging_r;

assign enable_trigger = enable_trigger_r;
assign enable_pwm = enable_pwm_r;
assign multi_pulse = multi_pulse_r;
assign frequency = frequency_r;
assign pulse_width_0 = pulse_width_0_r;
assign pulse_delay_0 = pulse_delay_0_r;
assign pulse_width_1 = pulse_width_1_r;
assign pulse_delay_1 = pulse_delay_1_r;
assign pulse_width_2 = pulse_width_2_r;
assign pulse_delay_2 = pulse_delay_2_r;
assign pulse_width_3 = pulse_width_3_r;
assign pulse_delay_3 = pulse_delay_3_r;
assign pulse_width_4 = pulse_width_4_r;
assign pulse_delay_4 = pulse_delay_4_r;
assign pulse_width_5 = pulse_width_5_r;
assign pulse_delay_5 = pulse_delay_5_r;
assign enable_charging = enable_charging_r;
assign PWM_ctrol_0 = PWM_ctrol_0_r;
assign PWM_ctrol_1 = PWM_ctrol_1_r;
assign PWM_ctrol_2 = PWM_ctrol_2_r;
assign PWM_ctrol_3 = PWM_ctrol_3_r;
assign PWM_ctrol_4 = PWM_ctrol_4_r;
assign PWM_ctrol_5 = PWM_ctrol_5_r;

always @(posedge clk or negedge rst)
if(!rst)	begin
	enable_trigger_r <= 6'b000000;	//all closed as default
	enable_pwm_r <= 6'b000000;	//all closed as default
	multi_pulse_r <= 1'b0;	//single as default
	frequency_r <= 16'd1;	//100kHz as default
	
	//all of pulse value is Zero as default
	pulse_width_0_r <= 16'd0;
	pulse_delay_0_r <= 16'd0;
	pulse_width_1_r <= 16'd0;
	pulse_delay_1_r <= 16'd0;
	pulse_width_2_r <= 16'd0;
	pulse_delay_2_r <= 16'd0;
	pulse_width_3_r <= 16'd0;
	pulse_delay_3_r <= 16'd0;
	pulse_width_4_r <= 16'd0;
	pulse_delay_4_r <= 16'd0;
	pulse_width_5_r <= 16'd0;
	pulse_delay_5_r <= 16'd0;
	
	enable_charging_r <= 1'b0;
	
	//all of PWM value is Zero as default
	PWM_ctrol_0_r <= 16'd0;
	PWM_ctrol_1_r <= 16'd0;
	PWM_ctrol_2_r <= 16'd0;
	PWM_ctrol_3_r <= 16'd0;
	PWM_ctrol_4_r <= 16'd0;
	PWM_ctrol_5_r <= 16'd0;
end
	else if(rcv_succ)	//recieved flag - the information should be analysed
		case(command)
			ENABLE: begin	enable_trigger_r <= data[13:8]; enable_pwm_r <= data[5:0];	end
			Single_Repeat:	if(data==16'd1292)	multi_pulse_r <= 1'b1;
								else if(data==16'd2921) multi_pulse_r <= 1'b0;
			Freq:	begin	frequency_r <= data;	end
			pw_0:	begin	pulse_width_0_r <= data;	end
			pw_1:	begin	pulse_width_1_r <= data;	end
			pw_2:	begin	pulse_width_2_r <= data;	end
			pw_3:	begin	pulse_width_3_r <= data;	end
			pw_4:	begin	pulse_width_4_r <= data;	end
			pw_5:	begin	pulse_width_5_r <= data;	end
			pd_0:	begin	pulse_delay_0_r <= data;	end
			pd_1:	begin	pulse_delay_1_r <= data;	end
			pd_2:	begin	pulse_delay_2_r <= data;	end
			pd_3:	begin	pulse_delay_3_r <= data;	end
			pd_4:	begin	pulse_delay_4_r <= data;	end
			pd_5:	begin	pulse_delay_5_r <= data;	end
			charging_en:	if(data==16'd872)	enable_charging_r <= 1'b1;
								else if(data==16'd278) enable_charging_r <= 1'b0;
			pwmd_0:	begin	PWM_ctrol_0_r <= data;	end
			pwmd_1:	begin	PWM_ctrol_1_r <= data;	end
			pwmd_2:	begin	PWM_ctrol_2_r <= data;	end
			pwmd_3:	begin	PWM_ctrol_3_r <= data;	end
			pwmd_4:	begin	PWM_ctrol_4_r <= data;	end
			pwmd_5:	begin	PWM_ctrol_5_r <= data;	end
		endcase

endmodule