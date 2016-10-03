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
	
	

wire [1:0] topLeft;
wire [1:0] topCenter;
wire [1:0] topRight;
wire [1:0] middleLeft;
wire [1:0] middleCenter;
wire [1:0] middleRight;
wire [1:0] bottonLeft;
wire [1:0] bottonCenter;
wire [1:0] bottonRight;

wire [2:0] state;

wire [8:0] xScore;
wire [8:0] yScore;

wire selectedOption;

reg [9:0] mousex = 200;
reg [9:0] mousey = 400;

Temporizer(
    .clk(clk),
    .Boton_izquierda(),
    .Boton_derecha(),
    .Boton_onoff(),
	
	//input signals from the mouse
	.mouseX(),
	.mouseY(),
	.mouseBotton(),
	
	//State of each of the cells
   .topLeft(topLeft),
	.topCenter(topCenter),
	.topRight(topRight),
	.middleLeft(middleLeft),
	.middleCenter(middleCenter),
	.middleRight(middleRight),
	.bottonLeft(bottonLeft),
	.bottonCenter(bottonCenter),
	.bottonRight(bottonRight),
	//Current State
	.state(state),
	
	//Score of each player
	.xScore(xScore),
	.OScore(yScore),
	
	//Current option for the buttons
	.selectedOption(selectedOption)
    );
			
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
