`timescale 1ns / 1ps

module Control_Unit(input [5:0] Instruction,

						  input [5:0] Funct,
						  
						  output RF_WRITE_ENABLE,
						  output DM_WRITE_ENABLE,
						  output MtoRFSEL,
						  output Branch,
						  output ALUInSel,
						  output RFDSel,
						  output JUMP,
						  output JR,
						  
						  output [2:0] ALUsel
    );
	 
	 wire [1:0] alu_op;
	 
	 Main_Decoder MD (.Instruction(Instruction),
							.Function(Funct),
							.RF_WRITE_ENABLE(RF_WRITE_ENABLE),
							.DM_WRITE_ENABLE(DM_WRITE_ENABLE),
							.MtoRFSEL(MtoRFSEL),
							.Branch(Branch),
							.ALUInSel(ALUInSel),
							.RFDSel(RFDSel),
							.ALUOp(alu_op),
							.JUMP(JUMP),
							.JR(JR));
	 
	 ALU_Decoder ALUD (.ALUOp(alu_op),
							 .Funct(Funct),
							 .ALUsel(ALUsel));


endmodule
