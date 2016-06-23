module RTC(
	clk,
	rst,
	stime	//1MHz
);

input clk, rst;
output stime;

parameter DIVIDE = 6'd50;	// control the frequency of stime
reg[5:0]	counter;
reg stime_r;

assign stime = stime_r;

always @(posedge clk or negedge rst)
if(!rst)	begin
	stime_r <= 1'b0;
	counter <= 6'd0;
end
	else if(counter < (DIVIDE - 6'd5))
		counter <= counter + 1'b1;
		else if(counter < DIVIDE)	begin
			counter <= counter + 1'b1;
			stime_r <= 1'b1;
		end
			else	begin
				stime_r <= 1'b0;
				counter <= 6'd0;
			end
			
endmodule