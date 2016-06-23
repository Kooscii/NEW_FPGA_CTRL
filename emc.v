module emc(
	clk,
	rstn
);
            
input clk;
output rstn;

reg[9:0] cnt;
reg r;

always @(posedge clk)
case (cnt) 
	10'd1021: begin cnt<=cnt+1'b1; r<=1'b0; end
	10'd1022: begin cnt<=cnt+1'b1; r<=1'b0; end
	10'd1023: begin cnt<=10'd1023; r<=1'b1; end
	default:  begin cnt<=cnt+1'b1; r<=1'b0; end
endcase

assign rstn=r;

endmodule 