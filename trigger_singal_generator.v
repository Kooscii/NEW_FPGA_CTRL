module trigger_singal_generator(
	clk,
	rst,
	
	//1MHz  timer
	stime,
	
	//multi-trigger input
	trigger_1,
	trigger_2,
	trigger_3,
	trigger_4,
	
	//single or repeatted flag
	multi_pulse,	// 0: single	1: repeated
	
	//enable trigger signal
	en_trigger,
	
	//frequency, the minimum is 0.01Hz which is also the Scal
	// the real F = frequency[14:0]*0.01Hz when MSB of frequency = 1
	//F = frequency[14:0]*10Hz when MSB of frequency = 0
	frequency,	
	
	//generated trigger singal output
	trigger,
	//the lock flag signal while repeated process
	latch
);

input clk, rst;
input stime;
input trigger_1, trigger_2, trigger_3, trigger_4;
input multi_pulse;
input[5:0] en_trigger;
input[15:0] frequency;
output trigger, latch;

reg trigger_r;
assign trigger = trigger_r;
reg latch_r;
assign latch = latch_r;

//all trigger signal combined into one wire, while each can be turn over
// High is positive
wire Trig = trigger_1|trigger_2|trigger_3|trigger_4;

reg[1:0] state;
parameter IDEL = 2'b00;
parameter CHG = 2'b01;
parameter WAIT = 2'b10;
parameter RTN = 2'b11;

reg[7:0]	counter;	//delay counter ~5.1us
reg internal_singal;	

always @(posedge clk or negedge rst)
if(!rst)	begin
	internal_singal <= 1'b0;
	state <= 2'b00;
	counter <= 8'd0;
	latch_r <= 1'b0;
	end
	else
		case(state)
			IDEL:	if(Trig) state <= CHG;
						else if(Rload) latch_r <= 1'b0;
			CHG:	if(counter < 8'd50)	//check whether the Trig singal exsits at last 1us
						counter <= counter + 1'b1;
						else if(Trig)	//Trig is still positive!
							state <= WAIT;
							else begin	//puzzle
								state <= IDEL;
								counter <= 8'd0;
								end
			WAIT:	if(counter < 8'd100)	begin	//the generated trigger singnal is 1us
						internal_singal <= 1'b1;
						counter <= counter + 1'b1;
						end
						else	begin
							internal_singal <= 1'b0;
							latch_r <= (multi_pulse)?(~latch_r):1'b0;	//the lock signal turn over when the falling edge of trigger
							state <= RTN;
							end
			RTN:	if(!Trig)	begin	//the Trig has gone
						counter <= 8'd0;
						state <= IDEL;
						end
			default:	begin counter <= 8'd0; internal_singal <= 1'b0; state <= IDEL; end
		endcase

//trigger singal generating process with single & multi_pulse
parameter timebase = 27'd100000;	//1MHz/10
wire[26:0] tick = (frequency[15])? (timebase/frequency[14:0]):(timebase*1000/frequency[14:0]);
reg[26:0] tock;

always @(posedge stime or negedge rst)
if(!rst)
	tock <= 27'd0;
	else if(latch)	begin	//repeated process
		if(tock < tick)
			tock <= tock + 1'b1;
			else
				tock <= 27'd0;
	end
	

always @(posedge clk or negedge rst)
if(!rst)
	trigger_r <= 1'b0;
	else
		case(multi_pulse)	//0:single	1:repeated
			1'b0:	trigger_r <= internal_singal;
			1'b1: if((tock > 27'd0)&&(tock < 27'd3))	//20us
						trigger_r <= 1'b1;
						else
							trigger_r <= 1'b0;
		endcase

//when the multi_pulse changed, all setting parameter should be reset!
reg befor;
reg[5:0] en_trigger_before;
reg[2:0] dcnt;
reg Rload;
always @(posedge clk or negedge rst)
if(!rst)	begin
	befor <= 1'b0;
	dcnt <= 3'd0;
	Rload <= 1'b0;
	en_trigger_before <= 6'd0;
	end
	else if((multi_pulse != befor)||(en_trigger != en_trigger_before))	begin
		if(dcnt < 3'd5)	begin
			dcnt <= dcnt + 1'b1;
			Rload <= 1'b1;
			end
			else	begin
				dcnt <= 3'd0;
				Rload <= 1'b0;
				befor <= multi_pulse;
				en_trigger_before <= en_trigger;
			end	
	end
		else	begin
			dcnt <= 3'd0;
			Rload <= 1'b0;
			befor <= multi_pulse;
			en_trigger_before <= en_trigger;
		end

		
endmodule