	module Chars_rom
   (
	input wire [7:0]  character,
    input wire [2:0] columnaY,
    output reg [7:0]  data
   );
      
   always @*
		//Numeros
		if(character == 0)//0
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b00111100; // 
				3'b010: data = 8'b01100110; // 
				3'b011: data = 8'b01101110; // 
				3'b100: data = 8'b01110110; // 
				3'b101: data = 8'b01100110; // 
				3'b110: data = 8'b00111100; // 
				3'b111: data = 8'b00000000; // 
			endcase
		else if(character == 1) //1
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b00001100; // 
				3'b010: data = 8'b00011100; // 
				3'b011: data = 8'b00001100; // 
				3'b100: data = 8'b00001100; // 
				3'b101: data = 8'b00001100; // 
				3'b110: data = 8'b01111110; // 
				3'b111: data = 8'b00000000; //   
			endcase
		else if(character == 2) //2
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b00111100; // 
				3'b010: data = 8'b01100110; // 
				3'b011: data = 8'b00000110; // 
				3'b100: data = 8'b00001100; // 
				3'b101: data = 8'b00110000; // 
				3'b110: data = 8'b01100000; // 
				3'b111: data = 8'b01111110; // 
			endcase
		else if(character == 3) //3
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b00111100; // 
				3'b010: data = 8'b01100110; // 
				3'b011: data = 8'b00000110; // 
				3'b100: data = 8'b00011100; // 
				3'b101: data = 8'b00000110; // 
				3'b110: data = 8'b01100110; // 
				3'b111: data = 8'b00111100; //  
			endcase
		else if(character == 4) //4
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b00001100; // 
				3'b010: data = 8'b00011100; // 
				3'b011: data = 8'b00111100; // 
				3'b100: data = 8'b11001100; // 
				3'b101: data = 8'b11111110; // 
				3'b110: data = 8'b00001100; // 
				3'b111: data = 8'b00001100; //  
			endcase
		else if(character == 5) //5
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b01111110; // 
				3'b010: data = 8'b01100000; // 
				3'b011: data = 8'b01111100; // 
				3'b100: data = 8'b00000110; // 
				3'b101: data = 8'b01100110; // 
				3'b110: data = 8'b00111100; // 
				3'b111: data = 8'b00000000; // 
			endcase
		else if(character == 6) //6
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b00111100; // 
				3'b010: data = 8'b01100110; // 
				3'b011: data = 8'b01100000; // 
				3'b100: data = 8'b01111100; // 
				3'b101: data = 8'b01100110; // 
				3'b110: data = 8'b01100110; // 
				3'b111: data = 8'b00111100; //  
			endcase
		else if(character == 7) //7
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b01111110; // 
				3'b010: data = 8'b01100110; // 
				3'b011: data = 8'b00001100; // 
				3'b100: data = 8'b00011000; // 
				3'b101: data = 8'b00011000; // 
				3'b110: data = 8'b00011000; // 
				3'b111: data = 8'b00011000; //  
			endcase
		else if(character == 8) //8
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b00111100; // 
				3'b010: data = 8'b01100110; // 
				3'b011: data = 8'b01100110; // 
				3'b100: data = 8'b00111100; // 
				3'b101: data = 8'b01100110; // 
				3'b110: data = 8'b01100110; // 
				3'b111: data = 8'b00111100; //  
			endcase
		else if(character == 9) //9
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b00111100; // 
				3'b010: data = 8'b01100110; // 
				3'b011: data = 8'b01100110; // 
				3'b100: data = 8'b00111110; // 
				3'b101: data = 8'b00000110; // 
				3'b110: data = 8'b01100110; // 
				3'b111: data = 8'b00111100; //  
			endcase
		//Letras
		else if(character == "A") //A
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b00011000; // 
				3'b010: data = 8'b00111100; // 
				3'b011: data = 8'b01100110; // 
				3'b100: data = 8'b01111110; // 
				3'b101: data = 8'b01100110; // 
				3'b110: data = 8'b01100110; // 
				3'b111: data = 8'b01100110; // 
			endcase
		else if(character == "B") //B
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b01111100; // 
				3'b010: data = 8'b01100110; // 
				3'b011: data = 8'b01100110; // 
				3'b100: data = 8'b01111100; // 
				3'b101: data = 8'b01100110; // 
				3'b110: data = 8'b01100110; // 
				3'b111: data = 8'b01111100; // 
			endcase
		else if(character == "C") //C
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b00111100; // 
				3'b010: data = 8'b01100110; // 
				3'b011: data = 8'b01100000; // 
				3'b100: data = 8'b01100000; // 
				3'b101: data = 8'b01100000; // 
				3'b110: data = 8'b01100110; // 
				3'b111: data = 8'b00111100; //  
			endcase
		else if(character == "D") //D
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b01111000; // 
				3'b010: data = 8'b01101100; // 
				3'b011: data = 8'b01100110; // 
				3'b100: data = 8'b01100110; // 
				3'b101: data = 8'b01100110; // 
				3'b110: data = 8'b01101100; // 
				3'b111: data = 8'b01111000; // 
			endcase
		else if(character == "E") //E
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b01111110; // 
				3'b010: data = 8'b01100000; // 
				3'b011: data = 8'b01100000; // 
				3'b100: data = 8'b01111000; // 
				3'b101: data = 8'b01100000; // 
				3'b110: data = 8'b01100000; // 
				3'b111: data = 8'b01111110; //  
			endcase
		else if(character == "F") //F
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b01111110; // 
				3'b010: data = 8'b01100000; // 
				3'b011: data = 8'b01100000; // 
				3'b100: data = 8'b01111000; // 
				3'b101: data = 8'b01100000; // 
				3'b110: data = 8'b01100000; // 
				3'b111: data = 8'b01100000; // 
			endcase
		else if(character == "G") //G
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b00111100; // 
				3'b010: data = 8'b01100110; // 
				3'b011: data = 8'b01100000; // 
				3'b100: data = 8'b01101110; // 
				3'b101: data = 8'b01100110; // 
				3'b110: data = 8'b01100110; // 
				3'b111: data = 8'b00111100; // 
			endcase
		else if(character == "H") //H
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b01100110; // 
				3'b010: data = 8'b01100110; // 
				3'b011: data = 8'b01100110; // 
				3'b100: data = 8'b01111110; // 
				3'b101: data = 8'b01100110; // 
				3'b110: data = 8'b01100110; // 
				3'b111: data = 8'b01100110; // 
			endcase
		else if(character == "I") //I
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b00111100; // 
				3'b010: data = 8'b00011000; // 
				3'b011: data = 8'b00011000; // 
				3'b100: data = 8'b00011000; // 
				3'b101: data = 8'b00011000; // 
				3'b110: data = 8'b00011000; // 
				3'b111: data = 8'b00111100; // 
			endcase
		else if(character == "J") //J
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b00011110; // 
				3'b010: data = 8'b00001100; // 
				3'b011: data = 8'b00001100; // 
				3'b100: data = 8'b00001100; // 
				3'b101: data = 8'b00001100; // 
				3'b110: data = 8'b01101100; // 
				3'b111: data = 8'b00111000; //
			endcase
		else if(character == "K") //K
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b01100110; // 
				3'b010: data = 8'b01101100; // 
				3'b011: data = 8'b0111100; // 
				3'b100: data = 8'b01110000; // 
				3'b101: data = 8'b01111000; // 
				3'b110: data = 8'b01101100; // 
				3'b111: data = 8'b01100110; //
			endcase
		else if(character == "L") //L
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b01100000; // 
				3'b010: data = 8'b01100000; // 
				3'b011: data = 8'b01100000; // 
				3'b100: data = 8'b01100000; // 
				3'b101: data = 8'b01100000; // 
				3'b110: data = 8'b01100000; // 
				3'b111: data = 8'b01111110; // 
			endcase
		else if(character == "M") //M
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b11000110; // 
				3'b010: data = 8'b11101110; // 
				3'b011: data = 8'b11111110; // 
				3'b100: data = 8'b11010110; // 
				3'b101: data = 8'b11000110; // 
				3'b110: data = 8'b11000110; // 
				3'b111: data = 8'b11000110; // 
			endcase
		else if(character == "N") //N
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b01100110; // 
				3'b010: data = 8'b01110110; // 
				3'b011: data = 8'b01111110; // 
				3'b100: data = 8'b01101110; // 
				3'b101: data = 8'b01100110; // 
				3'b110: data = 8'b01100110; // 
				3'b111: data = 8'b01100110; // 
			endcase
		else if(character == "O") //O
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b00111100; // 
				3'b010: data = 8'b01100110; // 
				3'b011: data = 8'b01100110; // 
				3'b100: data = 8'b01100110; // 
				3'b101: data = 8'b01100110; // 
				3'b110: data = 8'b01100110; // 
				3'b111: data = 8'b00111100; // 
			endcase
		else if(character == "P") //P
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b01111100; // 
				3'b010: data = 8'b01100110; // 
				3'b011: data = 8'b01100110; // 
				3'b100: data = 8'b01111100; // 
				3'b101: data = 8'b01100000; // 
				3'b110: data = 8'b01100000; // 
				3'b111: data = 8'b01100000; // 
			endcase
		else if(character == "Q") //Q
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b00111100; // 
				3'b010: data = 8'b01100110; // 
				3'b011: data = 8'b01100110; // 
				3'b100: data = 8'b01100110; // 
				3'b101: data = 8'b01100110; // 
				3'b110: data = 8'b00111100; // 
				3'b111: data = 8'b00001110; // 
			endcase
		else if(character == "R") //R
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b01111100; // 
				3'b010: data = 8'b01100110; // 
				3'b011: data = 8'b01100110; // 
				3'b100: data = 8'b01111100; // 
				3'b101: data = 8'b01111000; // 
				3'b110: data = 8'b01101100; // 
				3'b111: data = 8'b01100110; // 
			endcase
		else if(character == "S") //S
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b00111100; // 
				3'b010: data = 8'b01100110; // 
				3'b011: data = 8'b01100000; // 
				3'b100: data = 8'b00111100; // 
				3'b101: data = 8'b00000110; // 
				3'b110: data = 8'b01100110; // 
				3'b111: data = 8'b00111100; // 
			endcase
		else if(character == "T") //T
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b01111110; // 
				3'b010: data = 8'b00011000; // 
				3'b011: data = 8'b00011000; // 
				3'b100: data = 8'b00011000; // 
				3'b101: data = 8'b00011000; // 
				3'b110: data = 8'b00011000; // 
				3'b111: data = 8'b00011000; // 
			endcase
		else if(character == "U") //U
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b01100110; // 
				3'b010: data = 8'b01100110; // 
				3'b011: data = 8'b01100110; // 
				3'b100: data = 8'b01100110; // 
				3'b101: data = 8'b01100110; // 
				3'b110: data = 8'b01100110; // 
				3'b111: data = 8'b00111100; // 
			endcase
		else if(character == "V") //V
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b01100110; // 
				3'b010: data = 8'b01100110; // 
				3'b011: data = 8'b01100110; // 
				3'b100: data = 8'b01100110; // 
				3'b101: data = 8'b01100110; // 
				3'b110: data = 8'b00111100; // 
				3'b111: data = 8'b00011000; // 
			endcase
		else if(character == "W") //W
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b11000110; // 
				3'b010: data = 8'b11000110; // 
				3'b011: data = 8'b11000110; // 
				3'b100: data = 8'b11010110; // 
				3'b101: data = 8'b11111110; // 
				3'b110: data = 8'b11101110; // 
				3'b111: data = 8'b11000110; // 
			endcase
		else if(character == "X") //X
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b01100110; // 
				3'b010: data = 8'b01100110; // 
				3'b011: data = 8'b00111100; // 
				3'b100: data = 8'b00011000; // 
				3'b101: data = 8'b00111100; // 
				3'b110: data = 8'b01100110; // 
				3'b111: data = 8'b01100110; // 
			endcase
		else if(character == "Y") //Y
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b01100110; // 
				3'b010: data = 8'b01100110; // 
				3'b011: data = 8'b01100110; // 
				3'b100: data = 8'b00111100; // 
				3'b101: data = 8'b00011000; // 
				3'b110: data = 8'b00011000; // 
				3'b111: data = 8'b00011000; // 
			endcase
		else if(character == "Z") //Z
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b01111110; // 
				3'b010: data = 8'b00000110; // 
				3'b011: data = 8'b00001100; // 
				3'b100: data = 8'b00011000; // 
				3'b101: data = 8'b00110000; // 
				3'b110: data = 8'b01100000; // 
				3'b111: data = 8'b01111110; // 
			endcase
		else if(character == ":") //:
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b00011000; // 
				3'b010: data = 8'b00011000; // 
				3'b011: data = 8'b00000000; // 
				3'b100: data = 8'b00000000; // 
				3'b101: data = 8'b00011000; // 
				3'b110: data = 8'b00011000; // 
				3'b111: data = 8'b00000000; // 
			endcase
		else if(character == "'") //:
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b00011000; // 
				3'b010: data = 8'b00011000; // 
				3'b011: data = 8'b00011000; // 
				3'b100: data = 8'b00011000; // 
				3'b101: data = 8'b00000000; // 
				3'b110: data = 8'b00000000; // 
				3'b111: data = 8'b00000000; // 
			endcase
		else if(character == 94) //Up arrow
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b00011000; // 
				3'b010: data = 8'b00111100; // 
				3'b011: data = 8'b01111110; // 
				3'b100: data = 8'b00011000; // 
				3'b101: data = 8'b00011000; // 
				3'b110: data = 8'b00011000; // 
				3'b111: data = 8'b00000000; // 
			endcase
		else if(character == 95) //Left Triangle
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b01100000; // 
				3'b010: data = 8'b01111000; // 
				3'b011: data = 8'b01111110; // 
				3'b100: data = 8'b01111110; // 
				3'b101: data = 8'b01111000; // 
				3'b110: data = 8'b01100000; // 
				3'b111: data = 8'b00000000; // 
			endcase
		//Unrecoginzed Caracter
		else
			case (columnaY)
				3'b000: data = 8'b00000000; // 
				3'b001: data = 8'b00000000; // 
				3'b010: data = 8'b00000000; // 
				3'b011: data = 8'b00000000; // 
				3'b100: data = 8'b00000000; // 
				3'b101: data = 8'b00000000; // 
				3'b110: data = 8'b00000000; // 
				3'b111: data = 8'b00000000; // 
			endcase
		
endmodule