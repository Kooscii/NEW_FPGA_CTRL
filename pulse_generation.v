module pulse_generation(
	clk,
	rst,
	
	enable,	//6bit, each bit means the bit-pulse enable flag
	trigger,
	
	//6 pulse set value
	pulse_width_0,	pulse_delay_0,
	pulse_width_1,	pulse_delay_1,
	pulse_width_2,	pulse_delay_2,
	pulse_width_3,	pulse_delay_3,
	pulse_width_4,	pulse_delay_4,
	pulse_width_5,	pulse_delay_5,
	
	Pulse	//0~5
);

input clk, rst;
input[5:0] enable;
input trigger;
input[15:0] pulse_width_0,	pulse_delay_0;
input[15:0] pulse_width_1,	pulse_delay_1;
input[15:0] pulse_width_2,	pulse_delay_2;
input[15:0] pulse_width_3,	pulse_delay_3;
input[15:0] pulse_width_4,	pulse_delay_4;
input[15:0] pulse_width_5,	pulse_delay_5;
output[5:0] Pulse;

wire EN = (enable)?1'b1:1'b0;

reg[32:0] cnt;	//1ffffffffH = 171s
always@(posedge clk or negedge rst)
if(!rst)	//counter restarts
	cnt <= 33'h1ffffffff;
	else if(!EN)	//forbidden
		cnt <= 33'h1ffffffff;
		else if(trigger)	//enable
			cnt <= 32'd0;	//the timer starts when the falling edge of trigger
			else if(cnt < 33'h1ffffffff)
				cnt <= cnt + 1'b1;
				else
					cnt <= 33'h1ffffffff;

//Pusle generating Process
reg Pulse_0, Pulse_1, Pulse_2, Pulse_3, Pulse_4, Pulse_5;
assign Pulse[0] = Pulse_0;
assign Pulse[1] = Pulse_1 & Pulse_2;	//多通道实现一个Pulse动作2次
//assign Pulse[1] = Pulse_1;
assign Pulse[2] = Pulse_2;
assign Pulse[3] = Pulse_3;
assign Pulse[4] = Pulse_4;
assign Pulse[5] = Pulse_5;

always @(posedge clk or negedge rst)	//Pulse[0]
if(!rst)
	Pulse_0 <= 1'b1;	//the default value 1
	else if(!enable[0])
		Pulse_0 <= 1'b1;
		else if((cnt > (1'b0 + pulse_delay_0)) && (cnt < (1'b1 + pulse_delay_0 + pulse_width_0)))
			Pulse_0 <= 1'b0;
			else
				Pulse_0 <= 1'b1;
				
always @(posedge clk or negedge rst)	//Pulse[1]
if(!rst)
	Pulse_1 <= 1'b1;	//the default value 1
	else if(!enable[1])
		Pulse_1 <= 1'b1;
		else if((cnt > (1'b0 + pulse_delay_1)) && (cnt < (1'b1 + pulse_delay_1 + pulse_width_1)))
			Pulse_1 <= 1'b0;
			else
				Pulse_1 <= 1'b1;
				
always @(posedge clk or negedge rst)	//Pulse[2]
if(!rst)
	Pulse_2 <= 1'b1;	//the default value 1
	else if(!enable[2])
		Pulse_2 <= 1'b1;
		else if((cnt > (1'b0 + pulse_delay_2)) && (cnt < (1'b1 + pulse_delay_2 + pulse_width_2)))
			Pulse_2 <= 1'b0;
			else
				Pulse_2 <= 1'b1;

always @(posedge clk or negedge rst)	//Pulse[3]
if(!rst)
	Pulse_3 <= 1'b1;	//the default value 1
	else if(!enable[3])
		Pulse_3 <= 1'b1;
		else if((cnt > (1'b0 + pulse_delay_3)) && (cnt < (1'b1 + pulse_delay_3 + pulse_width_3)))
			Pulse_3 <= 1'b0;
			else
				Pulse_3 <= 1'b1;
				
always @(posedge clk or negedge rst)	//Pulse[4]
if(!rst)
	Pulse_4 <= 1'b1;	//the default value 1
	else if(!enable[4])
		Pulse_4 <= 1'b1;
		else if((cnt > (1'b0 + pulse_delay_4)) && (cnt < (1'b1 + pulse_delay_4 + pulse_width_4)))
			Pulse_4 <= 1'b0;
			else
				Pulse_4 <= 1'b1;
				
always @(posedge clk or negedge rst)	//Pulse[5]
if(!rst)
	Pulse_5 <= 1'b1;	//the default value 1
	else if(!enable[5])
		Pulse_5 <= 1'b1;
		else if((cnt > (1'b0 + pulse_delay_5)) && (cnt < (1'b1 + pulse_delay_5 + pulse_width_5)))
			Pulse_5 <= 1'b0;
			else
				Pulse_5 <= 1'b1;

endmodule