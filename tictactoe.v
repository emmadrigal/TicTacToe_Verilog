`timescale 1ns / 1ps

module TicTacToe(
    input clk,
    input Boton_izquierda,
    input Boton_derecha,
    input Boton_onoff,
	
	//input signals from the mouse
	input [9:0] mouseX,
	input [9:0] mouseY,
	input mouseBotton,
	
	//State of each of the cells
   output reg [1:0] topLeft,
	output reg [1:0] topCenter,
	output reg [1:0] topRight,
	output reg [1:0] middleLeft,
	output reg [1:0] middleCenter,
	output reg [1:0] middleRight,
	output reg [1:0] bottonLeft,
	output reg [1:0] bottonCenter,
	output reg [1:0] bottonRight,
	//Current State
	output [2:0] state,
	
	//Score of each player
	output reg [9:0] xScore,
	output reg [9:0] OScore,
	
	//Current option for the buttons
	output reg selectedOption
    );
	

assign state = estado_actual;

/*Estados
000: No ha empezado
001: O jugando
010: X jugando
011: Empate
100: X ganó
101: O ganó
*/
localparam [2:0] START  = 0,//No play has been made, a message is displayed
                 XsTurn = 1,//Xs Current Turn
					  OsTurn = 2,//Os Current Turn
					  Tie    = 3,//The game has finished in a Tie between O & X
					  XWins  = 4,//The game has been won by X
                 OWins  = 5;//The game has been won by O
				 
				 
//Parameters for the  PlayBoard
localparam playBoardTop      = 140;
localparam playBoardLeft     = 185;
localparam playBoardBarWidth =   9;
localparam CharSpace         =  84;
localparam playCharPadding   =  10;
/*
Valores de juego
00: Empty
01: O
10: X
*/


reg [2:0] estado_actual    = START;
reg [2:0] estado_siguiente = START;

//1 is reset Score and 0 is restart Match
reg selectedOption_reg = 0;

//Flags to indicate the winner
wire    Xwins;
wire    Owins;
reg  [3:0] Moves = 0;//Use to check if there's a tie


WinChecker Wins(
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
	
	//Current state of each player
	.Xwins(Xwins),
	.Owins(Owins)
    );



				  
///////////////////////////////////////////////////////////////
//Flags for the control of the input signals

//Usado para el control del Boton_Mouse
reg cambio_SolicitadoMouse = 0, cambio_RealizadoMouse = 0;
wire cambio_FinalizadoMouse;
assign cambio_FinalizadoMouse = ((cambio_RealizadoMouse & cambio_SolicitadoMouse) |  ((!cambio_RealizadoMouse) & (!cambio_SolicitadoMouse)));
				 
//Usado para el control del Boton_onoff
reg cambio_SolicitadoONOFF = 0, cambio_RealizadoONOFF = 0;
wire cambio_FinalizadoONOFF;
assign cambio_FinalizadoONOFF = ((cambio_RealizadoONOFF & cambio_SolicitadoONOFF) |  ((!cambio_RealizadoONOFF) & (!cambio_SolicitadoONOFF)));

//Usado para el control del Boton_derecha
reg cambio_SolicitadoRIGHT = 0, cambio_RealizadoRIGHT = 0;
wire cambio_FinalizadoRIGHT;
assign cambio_FinalizadoRIGHT = ((cambio_RealizadoRIGHT & cambio_SolicitadoRIGHT) |  ((!cambio_RealizadoRIGHT) & (!cambio_SolicitadoRIGHT)));

//Usado para el control del Boton_Izquierda
reg cambio_SolicitadoLEFT = 0, cambio_RealizadoLEFT = 0;
wire cambio_FinalizadoLEFT;
assign cambio_FinalizadoLEFT = ((cambio_RealizadoLEFT & cambio_SolicitadoLEFT) |  ((!cambio_RealizadoLEFT) & (!cambio_SolicitadoLEFT)));

//Logs a request for the use of the buttons
always @(posedge Boton_onoff)
	cambio_SolicitadoONOFF = ~cambio_SolicitadoONOFF;
	
always @(posedge Boton_derecha)
	cambio_SolicitadoRIGHT = ~cambio_SolicitadoRIGHT;
	
always @(posedge Boton_izquierda)
	cambio_SolicitadoLEFT = ~cambio_SolicitadoLEFT;
	
always @(posedge mouseBotton)
	cambio_SolicitadoMouse = ~cambio_SolicitadoMouse;

	

always @(posedge clk) begin
	estado_actual <= estado_siguiente;
	selectedOption <= selectedOption_reg;
	
	if(Xwins) begin
			estado_siguiente = XWins;
			topLeft      = 0;
			topCenter    = 0;
			topRight     = 0;
			middleLeft   = 0;
			middleCenter = 0;
			middleRight  = 0;
			bottonLeft   = 0;
			bottonCenter = 0;
			bottonRight  = 0;
			Moves = 0;
			xScore = xScore + 1;
		end
	else if(Owins) begin
			estado_siguiente = OWins;
			topLeft      = 0;
			topCenter    = 0;
			topRight     = 0;
			middleLeft   = 0;
			middleCenter = 0;
			middleRight  = 0;
			bottonLeft   = 0;
			bottonCenter = 0;
			bottonRight  = 0;
			Moves = 0;
			OScore = OScore + 1;
		end
	else if(Moves == 9 && !Xwins) begin
			estado_siguiente = Tie;
			topLeft      = 0;
			topCenter    = 0;
			topRight     = 0;
			middleLeft   = 0;
			middleCenter = 0;
			middleRight  = 0;
			bottonLeft   = 0;
			bottonCenter = 0;
			bottonRight  = 0;
			Moves = 0;
	end
	
	//Acts based on clicks from the mouse
	if(!cambio_FinalizadoMouse) begin
		//After the game is done, any clicks makes a new game
		if((state == Tie) || (state == XWins) || (state == OWins)) begin
			estado_siguiente = START;
		end
		
		//When the game is running it checks for entries on the symbols
		else if ((mouseX >= playBoardLeft) && (mouseX <= (playBoardLeft + CharSpace)) && (mouseY >= playBoardTop) && (mouseY <= (playBoardTop + CharSpace)) ) begin// Top left character
			if(topLeft == 0) begin
				if((state == XsTurn) || (state == START)) begin
					topLeft = 2;
					estado_siguiente = OsTurn;
					Moves = Moves + 1;
				end
				else if(state == OsTurn) begin
					topLeft = 1;
					estado_siguiente = XsTurn;
					Moves = Moves + 1;
				end
			end
		end
		
		else if ((mouseX >= (playBoardLeft + CharSpace + playBoardBarWidth)) && (mouseX <= (playBoardLeft + 2*CharSpace + playBoardBarWidth)) && (mouseY >= playBoardTop) && (mouseY <= (playBoardTop + CharSpace)) ) begin// Top center character
			if(topCenter == 0) begin
				if((state == XsTurn) || (state == START)) begin
					topCenter = 2;
					estado_siguiente = OsTurn;
					Moves = Moves + 1;
				end
				else if(state == OsTurn) begin
					topCenter = 1;
					estado_siguiente = XsTurn;
					Moves = Moves + 1;
				end
			end
		end
		
		else if ((mouseX >= (playBoardLeft + 2*CharSpace + 2*playBoardBarWidth)) && (mouseX <= (playBoardLeft + 3*CharSpace + 2*playBoardBarWidth)) && (mouseY >= playBoardTop) && (mouseY <= (playBoardTop + CharSpace)) ) begin// Top right character
			if(topRight == 0) begin
				if((state == XsTurn) || (state == START)) begin
					topRight = 2;
					estado_siguiente = OsTurn;
					Moves = Moves + 1;
				end
				else if(state == OsTurn) begin
					topRight = 1;
					estado_siguiente = XsTurn;
					Moves = Moves + 1;
				end
			end
		end
		
		else if ((mouseX >= playBoardLeft) && (mouseX <= (playBoardLeft + CharSpace)) && (mouseY >= (playBoardTop + CharSpace + playBoardBarWidth)) && (mouseY <= (playBoardTop + 2*CharSpace + playBoardBarWidth)) ) begin// Middle left character
			if(middleLeft == 0) begin
				if((state == XsTurn) || (state == START)) begin
					middleLeft = 2;
					estado_siguiente = OsTurn;
					Moves = Moves + 1;
				end
				else if(state == OsTurn) begin
					middleLeft = 1;
					estado_siguiente = XsTurn;
					Moves = Moves + 1;
				end
			end
		end
		
		else if ((mouseX >= (playBoardLeft + CharSpace + playBoardBarWidth)) && (mouseX <= (playBoardLeft + 2*CharSpace + playBoardBarWidth)) && (mouseY >= (playBoardTop + CharSpace + playBoardBarWidth)) && (mouseY <= (playBoardTop + 2*CharSpace + playBoardBarWidth)) ) begin// Middle center character
			if(middleCenter == 0) begin
				if((state == XsTurn) || (state == START)) begin
					middleCenter = 2;
					estado_siguiente = OsTurn;
					Moves = Moves + 1;
				end
				else if(state == OsTurn) begin
					middleCenter = 1;
					estado_siguiente = XsTurn;
					Moves = Moves + 1;
				end
			end
		end
		
		else if ((mouseX >= (playBoardLeft + 2*CharSpace + 2*playBoardBarWidth)) && (mouseX <= (playBoardLeft + 3*CharSpace + 2*playBoardBarWidth)) && (mouseY >= (playBoardTop + CharSpace + playBoardBarWidth)) && (mouseY <= (playBoardTop + 2*CharSpace + playBoardBarWidth)) ) begin// Middle right character
			if(middleRight == 0) begin
				if((state == XsTurn) || (state == START)) begin
					middleRight = 2;
					estado_siguiente = OsTurn;
					Moves = Moves + 1;
				end
				else if(state == OsTurn) begin
					middleRight = 1;
					estado_siguiente = XsTurn;
					Moves = Moves + 1;
				end
			end
		end
		
		else if ((mouseX >= playBoardLeft) && (mouseX <= (playBoardLeft + CharSpace)) && (mouseY >= (playBoardTop + 2*CharSpace + 2*playBoardBarWidth)) && (mouseY <= (playBoardTop + 3*CharSpace + 2*playBoardBarWidth)) ) begin// Botton left character
			if(bottonLeft == 0) begin
				if((state == XsTurn) || (state == START)) begin
					bottonLeft = 2;
					estado_siguiente = OsTurn;
					Moves = Moves + 1;
				end
				else if(state == OsTurn) begin
					bottonLeft = 1;
					estado_siguiente = XsTurn;
					Moves = Moves + 1;
				end
			end
		end
		
		else if ((mouseX >= (playBoardLeft + CharSpace + playBoardBarWidth)) && (mouseX <= (playBoardLeft + 2*CharSpace + playBoardBarWidth)) && (mouseY >= (playBoardTop + 2*CharSpace + 2*playBoardBarWidth)) && (mouseY <= (playBoardTop + 3*CharSpace + 2*playBoardBarWidth)) ) begin// Botton center character
			if(bottonCenter == 0) begin
				if((state == XsTurn) || (state == START)) begin
					bottonCenter = 2;
					estado_siguiente = OsTurn;
					Moves = Moves + 1;
				end
				else if(state == OsTurn) begin
					bottonCenter = 1;
					estado_siguiente = XsTurn;
					Moves = Moves + 1;
				end
			end
		end
		
		else if ((mouseX >= (playBoardLeft + 2*CharSpace + 2*playBoardBarWidth)) && (mouseX <= (playBoardLeft + 3*CharSpace + 2*playBoardBarWidth)) && (mouseY >= (playBoardTop + 2*CharSpace + 2*playBoardBarWidth)) && (mouseY <= (playBoardTop + 3*CharSpace + 2*playBoardBarWidth)) ) begin// Botton right character
			if(bottonRight == 0) begin
				if((state == XsTurn) || (state == START)) begin
					bottonRight = 2;
					estado_siguiente = OsTurn;
					Moves = Moves + 1;
				end
				else if(state == OsTurn) begin
					bottonRight = 1;
					estado_siguiente = XsTurn;
					Moves = Moves + 1;
				end
			end
		end
		
		cambio_RealizadoMouse = cambio_SolicitadoMouse;//Records that the instruction was recieved
	end
	
	if(!cambio_FinalizadoONOFF) begin //Si se presiona el boton de On OFF
		if(selectedOption) begin
			xScore = 0;
			OScore = 0;
		end
		else begin
			topLeft      = 0;
			topCenter    = 0;
			topRight     = 0;
			middleLeft   = 0;
			middleCenter = 0;
			middleRight  = 0;
			bottonLeft   = 0;
			bottonCenter = 0;
			bottonRight  = 0;
			Moves = 0;
			estado_siguiente = START;
		end
			
		cambio_RealizadoONOFF = cambio_SolicitadoONOFF;//Marque la bandera de que se realizó el cambio
	end
	
	//Cuando se presiona el boton de izquierda
	if(!cambio_FinalizadoLEFT) begin
		selectedOption_reg = ~selectedOption_reg;
		cambio_RealizadoLEFT = cambio_SolicitadoLEFT;//Marca la bandera de que se realizó el cambio
	end
	
	//Cuando se presiona el boton de derecha
	if(!cambio_FinalizadoRIGHT) begin
		selectedOption_reg = ~selectedOption_reg;
		cambio_RealizadoRIGHT = cambio_SolicitadoRIGHT;//Marca la bandera de que se realizó el cambio
	end
		
end

endmodule
