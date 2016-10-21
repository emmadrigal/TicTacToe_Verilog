`timescale 1ns / 1ps
 
module pixel_Gen(
	
	input [1:0] topLeft,
	input [1:0] topCenter,
	input [1:0] topRight,
	input [1:0] middleLeft,
	input [1:0] middleCenter,
	input [1:0] middleRight,
	input [1:0] bottonLeft,
	input [1:0] bottonCenter,
	input [1:0] bottonRight,
	input [2:0] state,
	
	input [9:0] xScore,
	input [9:0] yScore,
	
	input selectedOption,
	
	input [9:0] mousex,
	input [9:0] mousey,
	
	//Inputs from the sincronizer
    input pixel_tick,
	input wire [9:0] pixel_x, pixel_y,
	input wire video_on,
	
	//Salida de color segun el bit correspondiente
    output wire [7:0] rgb
   );
   
/*
Valores de juego
00: Empty
01: O
10: X
*/

/*Estados
000: No ha empezado
001: X jugando
010: O jugando
011: Empate
100: X ganó
101: O ganó
*/

// constant declaration

   localparam SymbolSize = 64 ; //Lenght of the side of the digit
   localparam expansionSize =  3;//Denotes log2(SymbolSize/8) it denotes how much bigger does the digit is on screen compared with the template, 1 is 1:1, 2 is 1:4, 3 is 1:16. From Verilog 2005 and on this can implemented as a function
	
	localparam ScoreSize = 32 ; //Lenght of the side of the digit
   localparam expansionScore =  2;//Denotes log2(DigitSize/8) 
	
	localparam TextSize = 16 ; //Lenght of the side of the digit
   localparam expansionText =  1;//Denotes log2(DigitSize/8)
	
   //Colors
   localparam white   = 8'b11111111;
   localparam blue    = 8'b11000000;
   localparam red     = 8'b00000111;
   localparam green   = 8'b00111000;
   localparam black   = 8'b00000000;
   localparam cyan    = 8'b11111000;
   localparam magenta = 8'b11000111;
   localparam yellow  = 8'b00111111;
   
//signal declaration
reg [7:0] rgb_reg;

//Current character to be drawn
reg [7:0] Character;
//Used to determine the height of the current pixel in the caracter
reg [2:0] columnY;
//Used to read the current row of pixels in the character
wire [7:0] row;

//Module instatiation
Chars_rom CharacterRom(.character(Character),  .columnaY(columnY),   .data(row));

//Parameters for the score
localparam XsScoreRight = 21;
localparam YsScoreRight = 391;
localparam ScoreTop = 40;


//Parameters for the top msg
localparam msgRight = 200;
localparam msgTop = 104;
reg [7:0] MSG [0:12];

//Parameters for the RESTART msg
localparam restartmsgRight = 76;
localparam restartmsgTop = 430;
wire [7:0] restartmsg [0:12];
assign restartmsg[0]  = "R";
assign restartmsg[1]  = "E";
assign restartmsg[2]  = "S";
assign restartmsg[3]  = "T";
assign restartmsg[4]  = "A";
assign restartmsg[5]  = "R";
assign restartmsg[6]  = "T";
assign restartmsg[7]  = " ";
assign restartmsg[8]  = "M";
assign restartmsg[9]  = "A";
assign restartmsg[10] = "T";
assign restartmsg[11] = "C";
assign restartmsg[12] = "H";

//Parameters for the  msg
localparam resetmsgRight = 367;
localparam resetmsgTop = 430;
wire [7:0] resetMSG [0:10];
assign resetMSG[0]  = "R";
assign resetMSG[1]  = "E";
assign resetMSG[2]  = "S";	
assign resetMSG[3]  = "E";
assign resetMSG[4]  = "T";
assign resetMSG[5]  = " ";
assign resetMSG[6]  = "S";
assign resetMSG[7]  = "C";
assign resetMSG[8]  = "O";
assign resetMSG[9]  = "R";
assign resetMSG[10] = "E";

//Parameters for the  msg
localparam playBoardTop      = 140;
localparam playBoardLeft     = 185;
localparam playBoardBarWidth =   9;
localparam CharSpace         =  84;
localparam playCharPadding   =  10;

//Parameters for the text at the top

//Checks that for a given pixel in the screen if it should be written
always @(posedge pixel_tick) begin
	if (video_on) begin
		
		//Xs Score, each character is of size 32
		if((pixel_x >= (XsScoreRight)) && (pixel_x <= (XsScoreRight + 5*ScoreSize)) && (pixel_y >= ScoreTop) && (pixel_y <= (ScoreTop + ScoreSize))) begin
			columnY = (pixel_y - ScoreTop) >> 2;//Includes Top position of the character and the expansion of the character
			if (pixel_x <= (XsScoreRight + ScoreSize)) begin//X character from the score
				Character = "X";//Character to be drawn
				if(row[7 -((pixel_x - XsScoreRight) >> 2)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (XsScoreRight + ScoreSize)) && (pixel_x <= (XsScoreRight + 2*ScoreSize))) begin//Msb from X's score
				Character = ":";//Character to be drawn
				if(row[7 -((pixel_x - (XsScoreRight + ScoreSize)) >> 2)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (XsScoreRight + 2*ScoreSize)) && (pixel_x <= (XsScoreRight + 3*ScoreSize))) begin//Msb from X's score
				Character = (xScore % 1000) / 100;//Character to be drawn
				if(row[7 -((pixel_x - (XsScoreRight + 2*ScoreSize)) >> 2)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (XsScoreRight + 3*ScoreSize)) && (pixel_x <= (XsScoreRight + 4*ScoreSize))) begin//Msb from X's score
				Character = (xScore % 100) / 10;//Character to be drawn
				if(row[7 -((pixel_x - (XsScoreRight + 2*ScoreSize)) >> 2)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if (pixel_x >= (XsScoreRight + 4*ScoreSize) ) begin//Msb from X's score
				Character = xScore % 10;//Character to be drawn
				if(row[7 -((pixel_x - (XsScoreRight + ScoreSize)) >> 2)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
		end
		
		
		//Ys Score, each character is of size 32
		else if((pixel_x >= (YsScoreRight)) && (pixel_x <= (YsScoreRight + 5*ScoreSize)) && (pixel_y >= ScoreTop) && (pixel_y <= (ScoreTop + ScoreSize))) begin
			columnY = (pixel_y - ScoreTop) >> 2;//Includes Top position of the character and the expansion of the character
			if (pixel_x <= (YsScoreRight + ScoreSize)) begin//Y character from the score
				Character = "O";//Character to be drawn
				if(row[7 -((pixel_x - YsScoreRight) >> 2)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (YsScoreRight + ScoreSize)) && (pixel_x <= (YsScoreRight + 2*ScoreSize))) begin//Msb from X's score
				Character = ":";//Character to be drawn
				if(row[7 -((pixel_x - (YsScoreRight + ScoreSize)) >> 2)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (YsScoreRight + 2*ScoreSize)) && (pixel_x <= (YsScoreRight + 3*ScoreSize))) begin//Msb from X's score
				Character = (yScore % 1000) / 100;//Character to be drawn
				if(row[7 -((pixel_x - (YsScoreRight + ScoreSize)) >> 2)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (YsScoreRight + 3*ScoreSize)) && (pixel_x <= (YsScoreRight + 4*ScoreSize))) begin//Msb from X's score
				Character = (yScore % 100) / 10;//Character to be drawn
				if(row[7 -((pixel_x - (YsScoreRight + ScoreSize)) >> 2)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if (pixel_x >= (YsScoreRight + 4*ScoreSize)) begin//Msb from X's score
				Character = yScore % 10;//Character to be drawn
				if(row[7 -((pixel_x - (YsScoreRight + ScoreSize)) >> 2)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
		end
		
		
		//Message at the top of the screen, each character is of size 16
		else if ((pixel_x >= msgRight) && (pixel_x <= (msgRight + 13*TextSize)) && (pixel_y >= msgTop) && (pixel_y <= (msgTop + TextSize))) begin
			columnY = (pixel_y - msgTop) >> 1;//Includes Top position of the character and the expansion of the character 
			if (pixel_x <= (msgRight + 1*TextSize)) begin// 
				Character = MSG[0];//Character to be drawn 
				if(row[7-((pixel_x - (msgRight + 0*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character 
					rgb_reg = blue;//Color to be drawn 
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (msgRight + 1*TextSize)) && (pixel_x <= (msgRight + 2*TextSize))) begin// 
				Character = MSG[1];//Character to be drawn 
				if(row[7-((pixel_x - (msgRight + 1*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character 
					rgb_reg = blue;//Color to be drawn 
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (msgRight + 2*TextSize)) && (pixel_x <= (msgRight + 3*TextSize))) begin// 
				Character = MSG[2];//Character to be drawn 
				if(row[7-((pixel_x - (msgRight + 2*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character 
					rgb_reg = blue;//Color to be drawn 
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (msgRight + 3*TextSize)) && (pixel_x <= (msgRight + 4*TextSize))) begin// 
				Character = MSG[3];//Character to be drawn 
				if(row[7-((pixel_x - (msgRight + 3*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character 
					rgb_reg = blue;//Color to be drawn 
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (msgRight + 4*TextSize)) && (pixel_x <= (msgRight + 5*TextSize))) begin// 
				Character = MSG[4];//Character to be drawn 
				if(row[7-((pixel_x - (msgRight + 4*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character 
					rgb_reg = blue;//Color to be drawn 
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (msgRight + 5*TextSize)) && (pixel_x <= (msgRight + 6*TextSize))) begin// 
				Character = MSG[5];//Character to be drawn 
				if(row[7-((pixel_x - (msgRight + 5*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character 
					rgb_reg = blue;//Color to be drawn 
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (msgRight + 6*TextSize)) && (pixel_x <= (msgRight + 7*TextSize))) begin// 
				Character = MSG[6];//Character to be drawn 
				if(row[7-((pixel_x - (msgRight + 6*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character 
					rgb_reg = blue;//Color to be drawn 
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (msgRight + 7*TextSize)) && (pixel_x <= (msgRight + 8*TextSize))) begin// 
				Character = MSG[7];//Character to be drawn 
				if(row[7-((pixel_x - (msgRight + 7*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character 
					rgb_reg = blue;//Color to be drawn 
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (msgRight + 8*TextSize)) && (pixel_x <= (msgRight + 9*TextSize))) begin// 
				Character = MSG[8];//Character to be drawn 
				if(row[7-((pixel_x - (msgRight + 8*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character 
					rgb_reg = blue;//Color to be drawn 
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (msgRight + 9*TextSize)) && (pixel_x <= (msgRight + 10*TextSize))) begin// 
				Character = MSG[9];//Character to be drawn 
				if(row[7-((pixel_x - (msgRight + 9*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character 
					rgb_reg = blue;//Color to be drawn 
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (msgRight + 10*TextSize)) && (pixel_x <= (msgRight + 11*TextSize))) begin// 
				Character = MSG[10];//Character to be drawn 
				if(row[7-((pixel_x - (msgRight + 10*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character 
					rgb_reg = blue;//Color to be drawn 
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (msgRight + 11*TextSize)) && (pixel_x <= (msgRight + 12*TextSize))) begin// 
				Character = MSG[11];//Character to be drawn 
				if(row[7-((pixel_x - (msgRight + 11*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character 
					rgb_reg = blue;//Color to be drawn 
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if (pixel_x >= (msgRight + 12*TextSize)) begin// 
				Character = MSG[12];//Character to be drawn 
				if(row[7-((pixel_x - (msgRight + 12*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character 
					rgb_reg = blue;//Color to be drawn 
				else
					rgb_reg = black;//Otherwise it's black
			end		
		end
		
		
		//Restart Match option, each character is of size 16
		else if ((pixel_x >= restartmsgRight) && (pixel_x <= (restartmsgRight + 13*TextSize)) && (pixel_y >= restartmsgTop) && (pixel_y <= (restartmsgTop + TextSize))) begin
			columnY = (pixel_y - restartmsgTop) >> 1;//Includes Top position of the character and the expansion of the character
			if ((pixel_x >= restartmsgRight) && (pixel_x <= (restartmsgRight + 1* TextSize)) ) begin//
				Character = restartmsg[ 0 ];//Character to be drawn
				if(row[7 -((pixel_x - restartmsgRight) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (restartmsgRight + 1*TextSize)) && (pixel_x <= (restartmsgRight + 2* TextSize)) ) begin//
				Character = restartmsg[ 1 ];//Character to be drawn
				if(row[7 -((pixel_x - (restartmsgRight + 1*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (restartmsgRight + 2*TextSize)) && (pixel_x <= (restartmsgRight + 3* TextSize)) ) begin//
				Character = restartmsg[ 2 ];//Character to be drawn
				if(row[7 -((pixel_x - (restartmsgRight + 2*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (restartmsgRight + 3*TextSize)) && (pixel_x <= (restartmsgRight + 4* TextSize)) ) begin//
				Character = restartmsg[ 3 ];//Character to be drawn
				if(row[7 -((pixel_x - (restartmsgRight + 3*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (restartmsgRight + 4*TextSize)) && (pixel_x <= (restartmsgRight + 5* TextSize)) ) begin//
				Character = restartmsg[ 4 ];//Character to be drawn
				if(row[7 -((pixel_x - (restartmsgRight + 4*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (restartmsgRight + 5*TextSize)) && (pixel_x <= (restartmsgRight + 6* TextSize)) ) begin//
				Character = restartmsg[ 5 ];//Character to be drawn
				if(row[7 -((pixel_x - (restartmsgRight + 5*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (restartmsgRight + 6*TextSize)) && (pixel_x <= (restartmsgRight + 7* TextSize)) ) begin//
				Character = restartmsg[ 6 ];//Character to be drawn
				if(row[7 -((pixel_x - (restartmsgRight + 6*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (restartmsgRight + 7*TextSize)) && (pixel_x <= (restartmsgRight + 8* TextSize)) ) begin//
				Character = restartmsg[ 7 ];//Character to be drawn
				if(row[7 -((pixel_x - (restartmsgRight + 7*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (restartmsgRight + 8*TextSize)) && (pixel_x <= (restartmsgRight + 9* TextSize)) ) begin//
				Character = restartmsg[ 8 ];//Character to be drawn
				if(row[7 -((pixel_x - (restartmsgRight + 8*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (restartmsgRight + 9*TextSize)) && (pixel_x <= (restartmsgRight + 10* TextSize)) ) begin//
				Character = restartmsg[ 9 ];//Character to be drawn
				if(row[7 -((pixel_x - (restartmsgRight + 9*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (restartmsgRight + 10*TextSize)) && (pixel_x <= (restartmsgRight + 11* TextSize)) ) begin//
				Character = restartmsg[ 10 ];//Character to be drawn
				if(row[7 -((pixel_x - (restartmsgRight + 10*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if ((pixel_x >= (restartmsgRight + 11*TextSize)) && (pixel_x <= (restartmsgRight + 12* TextSize)) ) begin//
				Character = restartmsg[ 11 ];//Character to be drawn
				if(row[7 -((pixel_x - (restartmsgRight + 11*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
			else if (pixel_x >= (restartmsgRight + 12*TextSize) ) begin//
				Character = restartmsg[ 12 ];//Character to be drawn
				if(row[7 -((pixel_x - (restartmsgRight + 12*TextSize)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else
					rgb_reg = black;//Otherwise it's black
			end
		end
		
		
		//Reset Score Option
		else if ((pixel_x >= resetmsgRight) && (pixel_x <= (resetmsgRight + 11*TextSize)) && (pixel_y >= resetmsgTop) && (pixel_y <= (resetmsgTop + TextSize))) begin
			columnY = (pixel_y - resetmsgTop) >> 1;//Includes Top position of the character and the expansion of the character 
			if (pixel_x <= (TextSize + resetmsgRight)) begin//
				Character = resetMSG[0];//Character to be drawn
				if(row[7 -((pixel_x - resetmsgRight) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else 
					rgb_reg = black;//Otherwise it's black 
			end
			else if ((pixel_x >= (TextSize + resetmsgRight)) && (pixel_x <= (2*TextSize + resetmsgRight))) begin//
				Character = resetMSG[1];//Character to be drawn
				if(row[7 -((pixel_x - (TextSize + resetmsgRight)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else 
					rgb_reg = black;//Otherwise it's black 
			end
			else if ((pixel_x >= (2*TextSize + resetmsgRight)) && (pixel_x <= (3*TextSize + resetmsgRight))) begin//
				Character = resetMSG[2];//Character to be drawn
				if(row[7 -((pixel_x - (2*TextSize + resetmsgRight)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else 
					rgb_reg = black;//Otherwise it's black 
			end
			else if ((pixel_x >= (3*TextSize + resetmsgRight)) && (pixel_x <= (4*TextSize + resetmsgRight))) begin//
				Character = resetMSG[3];//Character to be drawn
				if(row[7 -((pixel_x - (3*TextSize + resetmsgRight)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else 
					rgb_reg = black;//Otherwise it's black 
			end
			else if ((pixel_x >= (4*TextSize + resetmsgRight)) && (pixel_x <= (5*TextSize + resetmsgRight))) begin//
				Character = resetMSG[4];//Character to be drawn
				if(row[7 -((pixel_x - (4*TextSize + resetmsgRight)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else 
					rgb_reg = black;//Otherwise it's black 
			end
			else if ((pixel_x >= (5*TextSize + resetmsgRight)) && (pixel_x <= (6*TextSize + resetmsgRight))) begin//
				Character = resetMSG[5];//Character to be drawn
				if(row[7 -((pixel_x - (5*TextSize + resetmsgRight)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else 
					rgb_reg = black;//Otherwise it's black 
			end
			else if ((pixel_x >= (6*TextSize + resetmsgRight)) && (pixel_x <= (7*TextSize + resetmsgRight))) begin//
				Character = resetMSG[6];//Character to be drawn
				if(row[7 -((pixel_x - (6*TextSize + resetmsgRight)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else 
					rgb_reg = black;//Otherwise it's black 
			end
			else if ((pixel_x >= (7*TextSize + resetmsgRight)) && (pixel_x <= (8*TextSize + resetmsgRight))) begin//
				Character = resetMSG[7];//Character to be drawn
				if(row[7 -((pixel_x - (7*TextSize + resetmsgRight)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else 
					rgb_reg = black;//Otherwise it's black 
			end
			else if ((pixel_x >= (8*TextSize + resetmsgRight)) && (pixel_x <= (9*TextSize + resetmsgRight))) begin//
				Character = resetMSG[8];//Character to be drawn
				if(row[7 -((pixel_x - (8*TextSize + resetmsgRight)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else 
					rgb_reg = black;//Otherwise it's black 
			end
			else if ((pixel_x >= (9*TextSize + resetmsgRight)) && (pixel_x <= (10*TextSize + resetmsgRight))) begin//
				Character = resetMSG[9];//Character to be drawn
				if(row[7 -((pixel_x - (9*TextSize + resetmsgRight)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else 
					rgb_reg = black;//Otherwise it's black 
			end
			else if (pixel_x >= (10*TextSize + resetmsgRight)) begin//
				Character = resetMSG[10];//Character to be drawn
				if(row[7 -((pixel_x - (10*TextSize + resetmsgRight)) >> 1)])//Includes Left position of the character and the expansion of the character
					rgb_reg = blue;//Color to be drawn
				else 
					rgb_reg = black;//Otherwise it's black 
			end
		end		
		else begin
			if(state < 3)begin//The game is in progress
				if(state == 0)begin
					MSG[0]  = "S";
					MSG[1]  = "T";
					MSG[2]  = "A";
					MSG[3]  = "R";
					MSG[4]  = "T";
					MSG[5]  = " ";
					MSG[6]  = "P";
					MSG[7]  = "L";
					MSG[8]  = "A";
					MSG[9]  = "Y";
					MSG[10] = "I";
					MSG[11] = "N";
					MSG[12] = "G";
				end
				else if(state == 1)begin
					MSG[0]  = " ";
					MSG[1]  = " ";
					MSG[2]  = " ";
					MSG[3]  = "X";
					MSG[4]  = " ";
					MSG[5]  = "T";
					MSG[6]  = "U";
					MSG[7]  = "R";
					MSG[8]  = "N";
					MSG[9]  = " ";
					MSG[10] = " ";
					MSG[11] = " ";
					MSG[12] = " ";
				end
				else if(state == 2)begin
					MSG[0]  = " ";
					MSG[1]  = " ";
					MSG[2]  = " ";
					MSG[3]  = "O";
					MSG[4]  = " ";
					MSG[5]  = "T";
					MSG[6]  = "U";
					MSG[7]  = "R";
					MSG[8]  = "N";
					MSG[9]  = " ";
					MSG[10] = " ";
					MSG[11] = " ";
					MSG[12] = " ";
				end
				
				//Bars
				if ((pixel_x >= (playBoardLeft + CharSpace)) && (pixel_x <= (playBoardLeft + CharSpace + playBoardBarWidth)) && (pixel_y >= playBoardTop) && (pixel_y <= (playBoardTop + 3*CharSpace + 2*playBoardBarWidth)))// First vertical Bar
					rgb_reg = green;//
					
				else if ((pixel_x >= (playBoardLeft + 2*CharSpace + playBoardBarWidth)) && (pixel_x <= (playBoardLeft + 2*CharSpace + 2*playBoardBarWidth)) && (pixel_y >= (playBoardTop )) && (pixel_y <= (playBoardTop + 3*CharSpace + 2*playBoardBarWidth)))// Second vertical Bar
					rgb_reg = green;//
					
				else if ((pixel_x >= playBoardLeft) && (pixel_x <= (playBoardLeft + 3*CharSpace + 2*playBoardBarWidth)) && (pixel_y >= (playBoardTop  + CharSpace)) && (pixel_y <= (playBoardTop + CharSpace + playBoardBarWidth)))// First horizontal Bar
					rgb_reg = green;//
					
				else if ((pixel_x >= playBoardLeft) && (pixel_x <= (playBoardLeft + 3*CharSpace + 2*playBoardBarWidth)) && (pixel_y >= (playBoardTop + 2*CharSpace + playBoardBarWidth)) && (pixel_y <= (playBoardTop + 2*CharSpace + 2*playBoardBarWidth)))// Second Horizontal Bar
					rgb_reg = green;//
					
				//Symbols
				else if ((pixel_x >= (playBoardLeft + playCharPadding)) && (pixel_x <= (playBoardLeft + playCharPadding + SymbolSize)) && (pixel_y >= (playBoardTop + playCharPadding)) && (pixel_y <= (playBoardTop + playCharPadding + SymbolSize)) ) begin// Top left character
					if(topLeft == 0)
						Character = " ";
					else if(topLeft == 1)
						Character = "O";
					else if (topLeft == 2)
						Character = "X";
					columnY = (pixel_y - (playBoardTop + playCharPadding)) >> 3;//Includes Top position of the character and the expansion of the character 
					if(row[7 -((pixel_x - (playBoardLeft + playCharPadding)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = cyan;
					else 
						rgb_reg = black;
				end
				
				else if ((pixel_x >= (playBoardLeft + playCharPadding + CharSpace + playBoardBarWidth)) && (pixel_x <= (playBoardLeft + playCharPadding + CharSpace + playBoardBarWidth + SymbolSize)) && (pixel_y >= (playBoardTop + playCharPadding)) && (pixel_y <= (playBoardTop + playCharPadding + SymbolSize)) ) begin// Top center character
					if(topCenter == 0)
						Character = " ";
					else if(topCenter == 1)
						Character = "O";
					else if (topCenter == 2)
						Character = "X";
					columnY = (pixel_y - (playBoardTop + playCharPadding)) >> 3;//Includes Top position of the character and the expansion of the character 
					if(row[7 -((pixel_x - (playBoardLeft + playCharPadding + CharSpace + playBoardBarWidth)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = cyan;
					else 
						rgb_reg = black;
				end
				
				else if ((pixel_x >= (playBoardLeft + playCharPadding + 2*CharSpace + 2*playBoardBarWidth)) && (pixel_x <= (playBoardLeft + playCharPadding + 2*CharSpace + 2*playBoardBarWidth + SymbolSize)) && (pixel_y >= (playBoardTop + playCharPadding)) && (pixel_y <= (playBoardTop + playCharPadding + SymbolSize)) ) begin// Top right character
					if(topRight == 0)
						Character = " ";
					else if(topRight == 1)
						Character = "O";
					else if (topRight == 2)
						Character = "X";
					columnY = (pixel_y - (playBoardTop + playCharPadding)) >> 3;//Includes Top position of the character and the expansion of the character  and the expansion of the character 
					if(row[7 -((pixel_x - (playBoardLeft + playCharPadding + 2*CharSpace + 2*playBoardBarWidth)) >> 3)])//Includes Left position of the
						rgb_reg = cyan;
					else 
						rgb_reg = black;
				end
				
				else if ((pixel_x >= (playBoardLeft + playCharPadding)) && (pixel_x <= (playBoardLeft + playCharPadding + SymbolSize)) && (pixel_y >= (playBoardTop + CharSpace + playBoardBarWidth + playCharPadding)) && (pixel_y <= (playBoardTop + CharSpace + playBoardBarWidth + playCharPadding + SymbolSize)) ) begin// Middle left character
					if(middleLeft == 0)
						Character = " ";
					else if(middleLeft == 1)
						Character = "O";
					else if (middleLeft == 2)
						Character = "X";
					columnY = (pixel_y - (playBoardTop + CharSpace + playBoardBarWidth + playCharPadding + SymbolSize)) >> 3;//Includes Top position of the character and the expansion of the character 
					if(row[7 -((pixel_x - (playBoardLeft + playCharPadding)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = cyan;
					else 
						rgb_reg = black;
				end
				
				else if ((pixel_x >= (playBoardLeft + playCharPadding + CharSpace + playBoardBarWidth)) && (pixel_x <= (playBoardLeft + playCharPadding + CharSpace + playBoardBarWidth + SymbolSize)) && (pixel_y >= (playBoardTop + CharSpace + playBoardBarWidth + playCharPadding)) && (pixel_y <= (playBoardTop + CharSpace + playBoardBarWidth + playCharPadding + SymbolSize)) ) begin// Middle center character
					if(middleCenter == 0)
						Character = " ";
					else if(middleCenter == 1)
						Character = "O";
					else if (middleCenter == 2)
						Character = "X";
					columnY = (pixel_y - (playBoardTop + CharSpace + playBoardBarWidth + playCharPadding + SymbolSize)) >> 3;//Includes Top position of the character and the expansion of the character 
					if(row[7 -((pixel_x - (playBoardLeft + playCharPadding + CharSpace + playBoardBarWidth)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = cyan;
					else 
						rgb_reg = black;
				end
				
				else if ((pixel_x >= (playBoardLeft + playCharPadding + 2*CharSpace + 2*playBoardBarWidth)) && (pixel_x <= (playBoardLeft + playCharPadding + 2*CharSpace + 2*playBoardBarWidth + SymbolSize)) && (pixel_y >= (playBoardTop + CharSpace + playBoardBarWidth + playCharPadding)) && (pixel_y <= (playBoardTop + CharSpace + playBoardBarWidth + playCharPadding + SymbolSize)) ) begin// Middle right character
					if(middleRight == 0)
						Character = " ";
					else if(middleRight == 1)
						Character = "O";
					else if (middleRight == 2)
						Character = "X";
					columnY = (pixel_y - (playBoardTop + CharSpace + playBoardBarWidth + playCharPadding + SymbolSize)) >> 3;//Includes Top position of the character and the expansion of the character 
					if(row[7 -((pixel_x - (playBoardLeft + playCharPadding + 2*CharSpace + 2*playBoardBarWidth)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = cyan;
					else 
						rgb_reg = black;
				end
				
				else if ((pixel_x >= (playBoardLeft + playCharPadding)) && (pixel_x <= (playBoardLeft + playCharPadding + SymbolSize)) && (pixel_y >= (playBoardTop + 2*CharSpace + 2*playBoardBarWidth + playCharPadding)) && (pixel_y <= (playBoardTop + 2*CharSpace + 2*playBoardBarWidth + playCharPadding + SymbolSize)) ) begin// Botton left character
					if(bottonLeft == 0)
						Character = " ";
					else if(bottonLeft == 1)
						Character = "O";
					else if (bottonLeft == 2)
						Character = "X";
					columnY = (pixel_y - (playBoardTop + 2*CharSpace + 2*playBoardBarWidth + playCharPadding)) >> 3;//Includes Top position of the character and the expansion of the character 
					if(row[7 -((pixel_x - (playBoardLeft + playCharPadding)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = cyan;
					else 
						rgb_reg = black;
				end
				
				else if ((pixel_x >= (playBoardLeft + playCharPadding + CharSpace + playBoardBarWidth)) && (pixel_x <= (playBoardLeft + playCharPadding + CharSpace + playBoardBarWidth + SymbolSize)) && (pixel_y >= (playBoardTop + 2*CharSpace + 2*playBoardBarWidth + playCharPadding)) && (pixel_y <= (playBoardTop + 2*CharSpace + 2*playBoardBarWidth + playCharPadding + SymbolSize)) ) begin// Botton center character
					if(bottonCenter == 0)
						Character = " ";
					else if(bottonCenter == 1)
						Character = "O";
					else if (bottonCenter == 2)
						Character = "X";
					columnY = (pixel_y - (playBoardTop + 2*CharSpace + 2*playBoardBarWidth + playCharPadding)) >> 3;//Includes Top position of the character and the expansion of the character 
					if(row[7 -((pixel_x - (playBoardLeft + playCharPadding + CharSpace + playBoardBarWidth)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = cyan;
					else 
						rgb_reg = black;
				end
				
				else if ((pixel_x >= (playBoardLeft + playCharPadding + 2*CharSpace + 2*playBoardBarWidth)) && (pixel_x <= (playBoardLeft + playCharPadding + 2*CharSpace + 2*playBoardBarWidth + SymbolSize)) && (pixel_y >= (playBoardTop + 2*CharSpace + 2*playBoardBarWidth + playCharPadding)) && (pixel_y <= (playBoardTop + 2*CharSpace + 2*playBoardBarWidth + playCharPadding + SymbolSize)) ) begin// Botton right character
					if(bottonRight == 0)
						Character = " ";
					else if(bottonRight == 1)
						Character = "O";
					else if (bottonRight == 2)
						Character = "X";
					columnY = (pixel_y - (playBoardTop + 2*CharSpace + 2*playBoardBarWidth + playCharPadding)) >> 3;//Includes Top position of the character and the expansion of the character 
					if(row[7 -((pixel_x - (playBoardLeft + playCharPadding + 2*CharSpace + 2*playBoardBarWidth)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = cyan;
					else 
						rgb_reg = black;
				end
				else
					rgb_reg = black;
				
				
					
			end		
			else if(state == 3) begin//Tie
				MSG[0]  = " ";
				MSG[1]  = "I";
				MSG[2]  = "T";
				MSG[3]  = "'";
				MSG[4]  = "S";
				MSG[5]  = " ";
				MSG[6]  = "A";
				MSG[7]  = " ";
				MSG[8]  = "D";
				MSG[9]  = "R";
				MSG[10] = "A";
				MSG[11] = "W";
				MSG[12] = " ";
				//This splits an X on the top side of the screen and a O on the button parte of the screen
				if ((pixel_x >= 192) && (pixel_x <= 320) && (pixel_y >= 211) && (pixel_y <= 339) ) begin// 
					Character = "X";//Character to be drawn 
					columnY = (pixel_y - 211) >> 4;//Includes Top position of the character and the expansion of the character 
					if(row[7 -((pixel_x - 192) >> 4)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = yellow;//Color to be drawn 
					else 
						rgb_reg = black;//Otherwise it's black 
				end
				else if ((pixel_x >= 320) && (pixel_x <= 448) && (pixel_y >= 211) && (pixel_y <= 339) ) begin// 
					Character = "O";//Character to be drawn 
					columnY = (pixel_y - 211) >> 4;//Includes Top position of the character and the expansion of the character 
					if(row[7 -((pixel_x - 320) >> 4)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = yellow;//Color to be drawn 
					else 
						rgb_reg = black;//Otherwise it's black 
				end
				else
					rgb_reg = black;
			end
			else if(state == 4) begin//X has won
				MSG[0]  = " ";
				MSG[1]  = " ";
				MSG[2]  = "X";
				MSG[3]  = " ";
				MSG[4]  = "H";
				MSG[5]  = "A";
				MSG[6]  = "S";
				MSG[7]  = " ";
				MSG[8]  = "W";
				MSG[9]  = "O";
				MSG[10] = "N";
				MSG[11] = " ";
				MSG[12] = " ";
				if ((pixel_x >= 192) && (pixel_x <= 448) && (pixel_y >= 147) && (pixel_y <= 403) ) begin// 
					Character = "X";//Character to be drawn 
					columnY = (pixel_y - 147) >> 5;//Includes Top position of the character and the expansion of the character 
					if(row[7 -((pixel_x - 192) >> 5)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = yellow;//Color to be drawn 
					else 
						rgb_reg = black;//Otherwise it's black 
				end
				else
					rgb_reg = black;
			end
			
			else if(state == 5) begin//O has won
				MSG[0]  = " ";
				MSG[1]  = " ";
				MSG[2]  = "O";
				MSG[3]  = " ";
				MSG[4]  = "H";
				MSG[5]  = "A";
				MSG[6]  = "S";
				MSG[7]  = " ";
				MSG[8]  = "W";
				MSG[9]  = "O";
				MSG[10] = "N";
				MSG[11] = " ";
				MSG[12] = " ";
				if ((pixel_x >= 192) && (pixel_x <= 448) && (pixel_y >= 147) && (pixel_y <= 403) ) begin// 
					Character = "O";//Character to be drawn 
					columnY = (pixel_y - 147) >> 5;//Includes Top position of the character and the expansion of the character 
					if(row[7 -((pixel_x - 192) >> 5)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = yellow;//Color to be drawn 
					else 
						rgb_reg = black;//Otherwise it's black 
				end
				else
					rgb_reg = black;
			end
			else
				rgb_reg = black;
		
			//Draws the mouse cursor on the screen
			if ((pixel_x >= (mousex - 4)) && (pixel_x <= (mousex + 4)) && (pixel_y >= (mousey - 4)) && (pixel_y <= (mousey + 4)) )begin// 
				Character = 94;//This is an arrow
				columnY = pixel_y - (mousey - 4);//Includes Top position of the character and the expansion of the character 
				if(row[7 -(pixel_x - (mousex - 4))])//Includes Left position of the character and the expansion of the character 
					rgb_reg = white;
			end
			
			if(selectedOption) begin//The current select option is Restart Match
				if ((pixel_x >= 351) && (pixel_x <= 367) && (pixel_y >= 430) && (pixel_y <= 446))begin
					
					Character = 95;//Character to be drawn
					columnY = (pixel_y - 430) >> 1;//Includes Top position of the character and the expansion of the character
					if(row[7 -((pixel_x - 351) >> 1)])//Includes Left position of the character and the expansion of the character
						rgb_reg = blue;//Color to be drawn
					else
						rgb_reg = black;//Otherwise it's black
					
				end
			end
			else begin//The current selected option is Reset Score
				if ((pixel_x >= 60) && (pixel_x <= 76) && (pixel_y >= 430) && (pixel_y <= 446))begin
					
					Character = 95;//Character to be drawn
					columnY = (pixel_y - 430) >> 1;//Includes Top position of the character and the expansion of the character
					if(row[7 -((pixel_x - 60) >> 1)])//Includes Left position of the character and the expansion of the character
						rgb_reg = blue;//Color to be drawn
					else
						rgb_reg = black;//Otherwise it's black
					
				end
			end
		
		end
	
	end
	else
		rgb_reg = black;
	
end 

//output
assign rgb = rgb_reg;

endmodule

