`timescale 1ns / 1ps


module top(
	input clk,
	output wire [7:0] RGB,
	output hsync,output vsync
    );

// signal declaration
   wire video_on, pixel_tick;
   wire enable;
   
   //Screen position
   wire [9:0] pixel_x, pixel_y;
	
	

reg [1:0] topLeft      = 2;
reg [1:0] topCenter    = 2;
reg [1:0] topRight     = 2;
reg [1:0] middleLeft   = 2;
reg [1:0] middleCenter = 2;
reg [1:0] middleRight  = 2;
reg [1:0] bottonLeft   = 2;
reg [1:0] bottonCenter = 2;
reg [1:0] bottonRight  = 2;		

wire [2:0] state;
assign state = 1;

reg [8:0] xScore = 50;
reg [8:0] yScore = 50;

reg selectedOption = 0;

reg [9:0] mousex = 200;
reg [9:0] mousey = 400;
			
pixel_Gen generator(
	.topLeft(topLeft),
	.topCenter(topCenter),
	.topRight(topRight),
	.middleLeft(middleLeft),
	.middleCenter(middleCenter),
	.middleRight(middleRight),
	.bottonLeft(bottonLeft),
	.bottonCenter(bottonCenter),
	.bottonRight(bottonRight),
	
	.state(state),
	
	.xScore(xScore),
	.yScore(yScore),
	
	.selectedOption(selectedOption),
	
	.mousex(mousex),
	.mousey(mousex),
	
   .pixel_tick(pixel_tick),
	.pixel_x(pixel_x),
	.pixel_y(pixel_y),
	.video_on(video_on),
   .rgb(RGB)
   );
	
//Control del VGA
vga_sync Sincronizador (.clk(clk), 
						.hsync(hsync), .vsync(vsync),
						.video_on(video_on), .p_tick(pixel_tick),
						.pixel_x(pixel_x), .pixel_y(pixel_y));

endmodule
