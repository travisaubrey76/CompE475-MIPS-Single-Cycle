`timescale 1ns / 1ps

module CU_tb;

	// Inputs
	reg [5:0] Instruction;
	reg [5:0] Funct;

	// Outputs
	wire RF_WRITE_ENABLE;
	wire DM_WRITE_ENABLE;
	wire MtoRFSEL;
	wire Branch;
	wire ALUInSel;
	wire RFDSel;
	wire [2:0] ALUsel;

	// Instantiate the Unit Under Test (UUT)
	Control_Unit uut (
		.Instruction(Instruction), 
		.Funct(Funct), 
		.RF_WRITE_ENABLE(RF_WRITE_ENABLE), 
		.DM_WRITE_ENABLE(DM_WRITE_ENABLE), 
		.MtoRFSEL(MtoRFSEL), 
		.Branch(Branch), 
		.ALUInSel(ALUInSel), 
		.RFDSel(RFDSel), 
		.ALUsel(ALUsel)
	);

	initial begin

		
		// Wait 10 ns for global reset to finish
		     Instruction = 6'b000000; Funct = 6'b100000; //ADD
		#10; Instruction = 6'b000000; Funct = 6'b100010; //SUB
		#10; Instruction = 6'b000000; Funct = 6'b100100; //AND
		#10; Instruction = 6'b000000; Funct = 6'b100101; //OR
		#10; Instruction = 6'b000000; Funct = 6'b101010; //SLT

		#10; Instruction = 6'b100011; Funct = 6'bXXXXXX; //LOAD WORD
		#10; Instruction = 6'b101011; Funct = 6'bXXXXXX; //STORE WORD
		#10; Instruction = 6'b000100; Funct = 6'bXXXXXX; //BEQ
		#10; $finish;
        
		// Add stimulus here

	end
      
endmodule

