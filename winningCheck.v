`timescale 1ns / 1ps

module WinChecker(
	//State of each of the cells
    input [1:0] topLeft,
	input [1:0] topCenter,
	input [1:0] topRight,
	input [1:0] middleLeft,
	input [1:0] middleCenter,
	input [1:0] middleRight,
	input [1:0] bottonLeft,
	input [1:0] bottonCenter,
	input [1:0] bottonRight
	
	//Current option for the buttons
	output wire Xwins,
	output wire Owins
    );
	
/*
Valores de juego
00: Empty
01: O
10: X
*/
	
wire Ax = (topLeft      == 2);
wire Bx = (topCenter    == 2);
wire Cx = (topRight     == 2);
wire Dx = (middleLeft   == 2);
wire Ex = (middleCenter == 2);
wire Fx = (middleRight  == 2);
wire Gx = (bottonLeft   == 2);
wire Hx = (bottonCenter == 2);
wire Ix = (bottonRight  == 2);

wire Ao = (topLeft      == 1);
wire Bo = (topCenter    == 1);
wire Co = (topRight     == 1);
wire Do = (middleLeft   == 1);
wire Eo = (middleCenter == 1);
wire Fo = (middleRight  == 1);
wire Go = (bottonLeft   == 1);
wire Ho = (bottonCenter == 1);
wire Io = (bottonRight  == 1);
	
assign Xwins = (Ax && Bx && Cx) || (Dx && Ex && Fx) || (Gx && Hx && Ix) || (Ax && Dx && Gx) || (Bx && Ex && Hx) || (Cx && Fx && Ix) || (Ax && Ex && Ix) || (Cx && Ex && Gx);
	
	
assign Owins = (Ao && Bo && Co) || (Do && Eo && Fo) || (Go && Ho && Io) || (Ao && Do && Go) || (Bo && Eo && Ho) || (Co && Fo && Io) || (Ao && Eo && Io) || (Co && Eo && Go);

