`timescale 1ns / 1ps

module mousecontroler(
//Inputs
	input reset,
	input clk,

// Bidirectionals
	inout dataps2,
	inout clkps2,

// Outputs
	output mouseclick,
	output pixelx,
	output pixely
    );

//Comando para poner el mouse en enable
localparam command=8'hf4;

//Maquina de estados de la interfaz del controlador del mouse
localparam [2:0]
		iniciar_envio=3'b000,
		realizando_envio=3'b001,
		esperando_reconozer=3'b010,
		recibido_paquete1=3'b011,
		recibido_paquete2=3'b100,
		recibido_paquete3=3'b101,
		completo=3'b111;

//señales de control
reg [2:0] estado_actual, estado_siguiente;
wire [7:0] movimiento_x, movimiento_y;
reg empezar_enviops2;
wire dato_recibido, dato_enviado;
reg [8:0] numero_x,siguiente_x,numero_y,siguiente_y;
reg mouseclick, siguiente_mouseclick;


//Maquina de estados inicio
always @(posedge clk,posedge reset)
 if (reset)
	begin
		estado_actual<=iniciar_envio;
		numero_x<=0;
		numero_y<=0;
		mouseclick<=0;
	end
 else
	begin
		estado_actual<=estado_siguiente;
		numero_x<=siguiente_x;
		numero_y<=siguiente_y;
		mouseclick<=siguiente_mouseclick;
	end
endmodule
