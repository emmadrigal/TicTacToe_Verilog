`timescale 1ns / 1ps

module tmp_FakeMouse(
	input clk,
	input upBtn,
	input downBtn,
	input leftBtn,
	input rightBtn,
	
	output reg [9:0] xPos,
	output reg [9:0] yPos
    );
	 
	 
initial begin
	xPos = 320;
	yPos = 240;
end

///////////////////////////////////////////////////////////////
//Flags for the control of the input signals

//Usado para el control del Boton_Up
reg cambio_SolicitadoUp = 0, cambio_RealizadoUp = 0;
wire cambio_FinalizadoUp;
assign cambio_FinalizadoUp = ((cambio_RealizadoUp & cambio_SolicitadoUp) |  ((!cambio_RealizadoUp) & (!cambio_SolicitadoUp)));
				 
//Usado para el control del Boton_Down
reg cambio_SolicitadoDown = 0, cambio_RealizadoDown = 0;
wire cambio_FinalizadoDown;
assign cambio_FinalizadoDown = ((cambio_RealizadoDown & cambio_SolicitadoDown) |  ((!cambio_RealizadoDown) & (!cambio_SolicitadoDown)));

//Usado para el control del Boton_derecha
reg cambio_SolicitadoRIGHT = 0, cambio_RealizadoRIGHT = 0;
wire cambio_FinalizadoRIGHT;
assign cambio_FinalizadoRIGHT = ((cambio_RealizadoRIGHT & cambio_SolicitadoRIGHT) |  ((!cambio_RealizadoRIGHT) & (!cambio_SolicitadoRIGHT)));

//Usado para el control del Boton_Izquierda
reg cambio_SolicitadoLEFT = 0, cambio_RealizadoLEFT = 0;
wire cambio_FinalizadoLEFT;
assign cambio_FinalizadoLEFT = ((cambio_RealizadoLEFT & cambio_SolicitadoLEFT) |  ((!cambio_RealizadoLEFT) & (!cambio_SolicitadoLEFT)));

//Logs a request for the use of the buttons
always @(posedge downBtn)
	cambio_SolicitadoDown = ~cambio_SolicitadoDown;

always @(posedge rightBtn)
	cambio_SolicitadoRIGHT = ~cambio_SolicitadoRIGHT;
	
always @(posedge leftBtn)
	cambio_SolicitadoLEFT = ~cambio_SolicitadoLEFT;
	
always @(posedge upBtn)
	cambio_SolicitadoUp = ~cambio_SolicitadoUp;
	
always @(posedge clk) begin
	if(!cambio_FinalizadoUp) begin
		yPos = yPos - 35;
		if(yPos > 640)
			yPos = 320;
		cambio_RealizadoUp = cambio_SolicitadoUp;//Marque la bandera de que se realizó el cambio
	end

	if(!cambio_FinalizadoDown) begin
		yPos = yPos + 35;
		if(yPos > 640)
			yPos = 320;
		cambio_RealizadoDown = cambio_SolicitadoDown;//Marque la bandera de que se realizó el cambio
	end
	
	if(!cambio_FinalizadoLEFT) begin
		xPos = xPos - 35;
		if(xPos > 480)
			xPos = 240;
		cambio_RealizadoLEFT = cambio_SolicitadoLEFT;//Marque la bandera de que se realizó el cambio
	end
	
	if(!cambio_FinalizadoRIGHT) begin
		xPos = xPos + 35;
		if(xPos > 480)
			xPos = 240;
		cambio_RealizadoRIGHT = cambio_SolicitadoRIGHT;//Marque la bandera de que se realizó el cambio
	end
end


endmodule
