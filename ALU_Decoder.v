`timescale 1ns / 1ps

module ALU_Decoder(
    input [5:0] Funct,
	 input [1:0] ALUOp,
    output reg[2:0] ALUsel
    );

always @(ALUOp or Funct) begin
	if (ALUOp == 2'b00) begin //I TYPE INSTRUCTION
		ALUsel <= 3'b010; //ADD
	end
	else if(ALUOp == 2'b01) begin //R TYPE INSTRUCTION USE FUNCTION FIELD
		ALUsel <= 3'b110; //SUBTRACT
	end
	else if (ALUOp == 2'b11) begin //LUI controller path
		ALUsel <= 3'b100; //LUI
	end
	else begin //ALUOp = 1X
		case (Funct) 
		
			6'b100000: begin
				ALUsel <= 3'b010; //ADD
			end
			
			6'b100010: begin
				ALUsel <= 3'b110; //SUBTRACT
			end
			
			6'b100100: begin
				ALUsel <= 3'b000; //AND
			end
			
			6'b100101: begin
				ALUsel <= 3'b001; //OR
			end
			
			6'b101010: begin //SLT
				ALUsel <= 3'b111;
			end
			
			6'b001000: begin //JR
				ALUsel <= 3'b010;
			end
			
			6'b000100: begin //SLLV
				ALUsel <= 3'b011;
			end
			
			default: begin
				ALUsel <= 3'b010; //Default ADD
			end
		
		endcase
	end

end

endmodule
