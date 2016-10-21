`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:05:02 10/18/2016 
// Design Name: 
// Module Name:    mouse_led 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
//Listing 10.5
module mouse_led (
	input clk,reset,
	inout wire ps2d, ps2c,
	output reg [9:0] px_reg,
	output reg [9:0] py_reg,
	output wire mouseclick
);


// signal declaration
reg [9:0] px_next;
reg [9:0] py_next;
wire [8:0] xm;
wire [8:0] ym;
wire [2:0] btnm;
wire m_done_tick;


reg yenable;
reg xenable;

initial begin
	px_reg=320;
	py_reg=240;
end

mouse mouse_unit
	(.clk(clk), .reset(reset), .ps2d(ps2d), .ps2c(ps2c),
	 .xm(xm), .ym(ym) , .btnm(btnm),
	 .m_done_tick(m_done_tick));

		 
always @(posedge m_done_tick) begin	
	px_reg <= px_reg + { {2{xm[7]}}, xm[7:0] };
	py_reg <= py_reg - { {2{ym[7]}}, ym[7:0] };

end

assign mouseclick = btnm[0];
endmodule
