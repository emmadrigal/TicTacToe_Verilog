`timescale 1ns / 1ps

module Top(
	input clk,reset,
	inout wire ps2d, ps2c,
	//output wire mouseclick2,

	output reg [7:0] seg,
	output reg [3:0] an,

	input linksBtn,
	input rechtsBtn,
	input zentrumBtn,

	output wire [7:0] RGB,	
	output hsync,output vsync
);
	 
wire [9:0] px_reg;
wire [9:0] py_reg;
wire mouseclick2;

// signal declaration
wire video_on, pixel_tick;
wire enable;

//Screen position
wire [9:0] pixel_x, pixel_y;
	
///Wires used for the game connection
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

wire [9:0] xScore;
wire [9:0] yScore;

wire selectedOption;

wire Links;
wire Rechts;
wire Zentrum;

debouncer DB6(.clk(clk), .PB(linksBtn), .PB_state(Links));
debouncer DB7(.clk(clk), .PB(rechtsBtn), .PB_state(Rechts));
debouncer DB8(.clk(clk), .PB(zentrumBtn), .PB_state(Zentrum));

TicTacToe gameLogic(
    .clk(clk),
    .Boton_izquierda(Links),
    .Boton_derecha(Rechts),
    .Boton_onoff(Zentrum),
	
	//input signals from the mouse
	.mouseX(px_reg),
	.mouseY(py_reg),
	.mouseBotton(mouseclick2),
	
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
			
pixel_Gen pixls(
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
	
	.mousex(px_reg),
	.mousey(py_reg),
	
   .pixel_tick(pixel_tick),
	.pixel_x(pixel_x),
	.pixel_y(pixel_y),
	.video_on(video_on),
   .rgb(RGB)
   );
	
//Control del VGA
vga_sync Sincronizador(.clk(clk), 
						.hsync(hsync), .vsync(vsync),
						.video_on(video_on), .p_tick(pixel_tick),
						.pixel_x(pixel_x), .pixel_y(pixel_y));
	 

	 // Instantiate the module
mouse_led instance_name (
    .clk(clk), 
    .reset(reset), 
    .ps2d(ps2d), 
    .ps2c(ps2c), 
    .px_reg(px_reg), 
    .py_reg(py_reg), 
    .mouseclick(mouseclick2)
    );

endmodule
