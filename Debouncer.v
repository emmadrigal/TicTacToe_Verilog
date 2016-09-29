`timescale 1ns / 1ps

module debouncer(
    input wire clk,
    input wire PB,
    output reg PB_state
    );
	 
reg PB_sync_0;
always @(posedge clk) PB_sync_0 <= PB; 
reg PB_sync_1;
always @(posedge clk) PB_sync_1 <= PB_sync_0;


reg [15:0] PB_cnt;


always @(posedge clk)
	if(PB_state==PB_sync_1)
		PB_cnt <= 0;
	else begin
		PB_cnt <= PB_cnt + 1'b1;  
		if(PB_cnt == 16'hffff) PB_state <= ~PB_state;  
	end
endmodule