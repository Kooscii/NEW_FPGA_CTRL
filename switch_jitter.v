module switch_jitter(	//this module aims to decrease the jitter from switch
	clk,	//50MHz
	rst,	//reset signal
	
	switch_input,
	
	switch_trigger
);

input clk, rst;
input switch_input;
output switch_trigger;

reg switch_trigger_r;
assign switch_trigger = switch_trigger_r;

parameter IDEL = 2'b00;
parameter RUN	= 2'b01;
parameter WAIT	= 2'b10;
parameter DONE	= 2'b11;

reg[1:0] state;	//state machine
reg[24:0] counter;	//0.5s = 25'h17D7840

always @(posedge clk or negedge rst)
if(!rst)	begin
	state <=  IDEL;
	switch_trigger_r <= 1'b0;
	counter <= 25'd0;
	end
	else
		case(state)
			IDEL: if(!switch_input)	//Low Level is triggered
						state <= RUN;
			RUN:	if(counter < 25'd500)	begin
						switch_trigger_r <= 1'b1;
						counter <= counter + 1'b1;
						end
						else	begin
							switch_trigger_r <= 1'b0;
							state <= WAIT;
							end
			WAIT:	if(counter < 25'h17D7840)	//0.5s switch jitter filter
						counter <= counter + 1'b1;
						else
							state <= DONE;
			DONE:	begin	state <= IDEL; counter <= 25'd0; switch_trigger_r <= 1'b0;	end
		endcase

endmodule

