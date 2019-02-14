`timescale 1ns / 1ps

module Main_Decoder(input [5:0] Instruction,
						  input [5:0] Function, 
						  
						  output reg RF_WRITE_ENABLE,
						  output reg DM_WRITE_ENABLE,
						  output reg MtoRFSEL,
						  output reg Branch,
						  output reg ALUInSel,
						  output reg RFDSel,
						  output reg JUMP,
						  output reg JR,
						  
						  output reg [1:0] ALUOp //2 bit ALU OPERATION SIGNAL
						  
						  );
	 
	 //Need to first determine what type of instruction is being read.
	 always @(Instruction or Function) begin
			//Determine what the instruction is.
			case (Instruction)
			
			6'b000000: begin //R TYPE INSTRUCTION
				if(Function == 6'b001000) begin
					RF_WRITE_ENABLE <= 0;
					DM_WRITE_ENABLE <= 0;
					MtoRFSEL <= 0;
					Branch <= 0;
					RFDSel <= 1'bX;
					ALUInSel <= 0;
					ALUOp <= 2'b10;
					JUMP <= 0;
					JR <= 1;
				end
				else begin		
					RF_WRITE_ENABLE <= 1;
					DM_WRITE_ENABLE <= 0;
					MtoRFSEL <= 0;
					Branch <= 0;
					RFDSel <= 1;
					ALUInSel <= 0;
					ALUOp <= 2'b10;
					JUMP <= 0;
					JR <= 0;
				end
				end
			
			6'b100011: begin //LOAD WORD
					RF_WRITE_ENABLE <= 1;
					DM_WRITE_ENABLE <= 0;
					MtoRFSEL <= 1;
					Branch <= 0;
					RFDSel <= 0;
					ALUInSel <= 1;
					ALUOp <= 2'b00;
					JUMP <= 0;
					JR <= 0;
				end
				
			6'b101011: begin //STORE WORD
					RF_WRITE_ENABLE <= 0;
					DM_WRITE_ENABLE <= 1;
					MtoRFSEL <= 1'bX;
					Branch <= 0;
					RFDSel <= 1'bX;
					ALUInSel <= 1;
					ALUOp <= 2'b00;
					JUMP <= 0;
					JR <= 0;
				end
				
			6'b000100: begin //BRANCH EQUIVALENT INSTRUCTION
					RF_WRITE_ENABLE <= 0;
					DM_WRITE_ENABLE <= 0;
					MtoRFSEL <= 1'bX;
					Branch <= 1;
					RFDSel <= 1'bX;
					ALUInSel <= 0;
					ALUOp <= 2'b01;
					JUMP <= 0;
					JR <= 0;
				end
				
			6'b001000: begin // Add Immediate Instruction
					RF_WRITE_ENABLE <= 1;
					DM_WRITE_ENABLE <= 0;
					MtoRFSEL <= 0;
					Branch <= 0;
					RFDSel <= 0;
					ALUInSel <= 1;
					ALUOp <= 2'b00;
					JUMP <= 0;
					JR <= 0;
				end
				
			6'b000010: begin //JUMP Instruction
					RF_WRITE_ENABLE <= 0;
					DM_WRITE_ENABLE <= 0;
					MtoRFSEL <= 1'bX;
					Branch <= 1'bX;
					RFDSel <= 1'bX;
					ALUInSel <= 1'bX;
					ALUOp <= 2'bXX;
					JUMP <= 1;
					JR <= 0;
			end
			
			6'b001111: begin //LUI Instruction
					RF_WRITE_ENABLE <= 1;
					DM_WRITE_ENABLE <= 0;
					MtoRFSEL <= 0;
					Branch <= 0;
					RFDSel <= 0;
					ALUInSel <= 1;
					ALUOp <= 2'b11;
					JUMP <= 0;
					JR <= 0;
			end
			
			default: begin //DEFAULT OPTION IS R TYPE INSTRUCTION
					RF_WRITE_ENABLE <= 1;
					DM_WRITE_ENABLE <= 0;
					MtoRFSEL <= 0;
					Branch <= 0;
					RFDSel <= 1;
					ALUInSel <= 0;
					ALUOp <= 2'b10;
					JUMP <= 0;
					JR <= 0;
				end
				
			endcase
	end
endmodule
