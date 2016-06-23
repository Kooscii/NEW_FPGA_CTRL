module pwm_generation(
	stime,	//PWM maximum frequency - 100kHz
	enable,	//PWM enable, 1: output
	
	enable_charging,	//charging enable flag, 1:output
	
	//16bit, H is MSB to 8, L is 7 to LSB
	//cal: frequency = 100kHz/H; duty = L/H
	//H equaling Zero is forbidden
	PWM_ctrol_0,
	PWM_ctrol_1,
	PWM_ctrol_2,
	PWM_ctrol_3,
	PWM_ctrol_4,
	PWM_ctrol_5,
	
	PWM	//PWM output 0~5
);

input stime;
input[5:0] enable;
input enable_charging;
input[15:0] PWM_ctrol_0, PWM_ctrol_1, PWM_ctrol_2, PWM_ctrol_3, PWM_ctrol_4, PWM_ctrol_5;
output[5:0] PWM;

reg[5:0] PWM_r;
assign PWM = (enable_charging)? PWM_r:6'b000000;

reg[7:0] cnt_0, cnt_1, cnt_2, cnt_3, cnt_4, cnt_5;

parameter dev = 10;	//clock = stime_frequency/10
reg[3:0] counter;
wire clock = clock_r;
reg clock_r;

always @(posedge stime)	//timer slower module	stime/dev
if(counter < dev-1)	begin
	clock_r <= 1'b0;
	counter <= counter + 1'b1;
	end
	else	begin
		counter <= 4'd0;
		clock_r <= 1'b1;
	end		

always @(posedge clock)	//PWM[0]
if(!enable[0])	begin
	PWM_r[0] <= 1'b0;
	cnt_0 <= 8'd0;
end
	else if(cnt_0 < PWM_ctrol_0[7:0])	begin	//Lower 8bit is High duty
		cnt_0 <= cnt_0 + 1'b1;
		PWM_r[0] <= 1'b1;
		end
		else if(cnt_0 <PWM_ctrol_0[15:8])	begin //Higher 8bit determines the PWM frequency
			cnt_0 <= cnt_0 + 1'b1;
			PWM_r[0] <= 1'b0;
			end
			else
				cnt_0 <= 8'd0;
	
always @(posedge clock)	//PWM[1]
if(!enable[1])	begin
	PWM_r[1] <= 1'b0;
	cnt_1 <= 8'd0;
end
	else if(cnt_1 < PWM_ctrol_1[7:0])	begin	//Lower 8bit is High duty
		cnt_1 <= cnt_1 + 1'b1;
		PWM_r[1] <= 1'b1;
		end
		else if(cnt_1 <PWM_ctrol_1[15:8])	begin //Higher 8bit determines the PWM frequency
			cnt_1 <= cnt_1 + 1'b1;
			PWM_r[1] <= 1'b0;
			end
			else
				cnt_1 <= 8'd0;
				
always @(posedge clock)	//PWM[2]
if(!enable[2])	begin
	PWM_r[2] <= 1'b0;
	cnt_2 <= 8'd0;
end
	else if(cnt_2 < PWM_ctrol_2[7:0])	begin	//Lower 8bit is High duty
		cnt_2 <= cnt_2 + 1'b1;
		PWM_r[2] <= 1'b1;
		end
		else if(cnt_2 <PWM_ctrol_2[15:8])	begin //Higher 8bit determines the PWM frequency
			cnt_2 <= cnt_2 + 1'b1;
			PWM_r[2] <= 1'b0;
			end
			else
				cnt_2 <= 8'd0;
				
always @(posedge clock)	//PWM[3]
if(!enable[3])	begin
	PWM_r[3] <= 1'b0;
	cnt_3 <= 8'd0;
end
	else if(cnt_3 < PWM_ctrol_3[7:0])	begin	//Lower 8bit is High duty
		cnt_3 <= cnt_3 + 1'b1;
		PWM_r[3] <= 1'b1;
		end
		else if(cnt_3 <PWM_ctrol_3[15:8])	begin //Higher 8bit determines the PWM frequency
			cnt_3 <= cnt_3 + 1'b1;
			PWM_r[3] <= 1'b0;
			end
			else
				cnt_3 <= 8'd0;
				
always @(posedge clock)	//PWM[4]
if(!enable[4])	begin
	PWM_r[4] <= 1'b0;
	cnt_4 <= 8'd0;
end
	else if(cnt_4 < PWM_ctrol_4[7:0])	begin	//Lower 8bit is High duty
		cnt_4 <= cnt_4 + 1'b1;
		PWM_r[4] <= 1'b1;
		end
		else if(cnt_4 <PWM_ctrol_4[15:8])	begin //Higher 8bit determines the PWM frequency
			cnt_4 <= cnt_4 + 1'b1;
			PWM_r[4] <= 1'b0;
			end
			else
				cnt_4 <= 8'd0;
	
always @(posedge clock)	//PWM[5]
if(!enable[5])	begin
	PWM_r[5] <= 1'b0;
	cnt_5 <= 8'd0;
end
	else if(cnt_5 < PWM_ctrol_5[7:0])	begin	//Lower 8bit is High duty
		cnt_5 <= cnt_5 + 1'b1;
		PWM_r[5] <= 1'b1;
		end
		else if(cnt_5 <PWM_ctrol_5[15:8])	begin //Higher 8bit determines the PWM frequency
			cnt_5 <= cnt_5 + 1'b1;
			PWM_r[5] <= 1'b0;
			end
			else
				cnt_5 <= 8'd0;
	
endmodule