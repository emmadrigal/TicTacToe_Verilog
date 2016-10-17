`timescale 1ns / 1ps


module top(
	input clk,
	input upBtn,
	input downBtn,
	input leftBtn,
	input rightBtn,
	input actionBtn,
	
	input linksBtn,
	input rechtsBtn,
	input zentrumBtn,
	
	output wire [7:0] RGB,	
	output hsync,output vsync
    );


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

wire [9:0] mousex;
wire [9:0] mousey;

wire Up;
wire Down;
wire Left;
wire Right;
wire Center;

wire Links;
wire Rechts;
wire Zentrum;

debouncer DB1(.clk(clk), .PB(upBtn), .PB_state(Up));
debouncer DB2(.clk(clk), .PB(downBtn), .PB_state(Down));
debouncer DB3(.clk(clk), .PB(leftBtn), .PB_state(Left));
debouncer DB4(.clk(clk), .PB(rightBtn), .PB_state(Right));
debouncer DB5(.clk(clk), .PB(actionBtn), .PB_state(Center));

debouncer DB6(.clk(clk), .PB(linksBtn), .PB_state(Links));
debouncer DB7(.clk(clk), .PB(rechtsBtn), .PB_state(Rechts));
debouncer DB8(.clk(clk), .PB(zentrumBtn), .PB_state(Zentrum));

tmp_FakeMouse fakeMouse(
	.clk(clk),
	.upBtn(Up),
	.downBtn(Down),
	.leftBtn(Left),
	.rightBtn(Right),
	
	.xPos(mousex),
	.yPos(mousey)
    );
	


TicTacToe gameLogic(
    .clk(clk),
    .Boton_izquierda(Links),
    .Boton_derecha(Rechts),
    .Boton_onoff(Zentrum),
	
	//input signals from the mouse
	.mouseX(mousex),
	.mouseY(mousey),
	.mouseBotton(Center),
	
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
	
	.mousex(mousex),
	.mousey(mousey),
	
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

endmodule
