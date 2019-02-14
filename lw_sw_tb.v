`timescale 1ns / 1ps


module LW_SW_tb;

	// Inputs
	reg CLK;
	reg RST;

	// Outputs
	wire [31:0] ALU_Output_Top;
	wire ALU_Overflow;
	wire ALU_Zero;
	wire Branch_Signal;
	wire [31:0] ALU_Input_1;
	wire [31:0] ALU_Input_2;
	wire [2:0] ALU_Select_Status;
	wire [31:0] REG_INPUT;
	wire [31:0] Counter;
	wire [31:0] Instruct;
	
	wire [5:0] OPCODE;
	wire [4:0] RS;
	wire [4:0] RT;
	wire [4:0] RD;
	wire [15:0] IMM;
	wire [5:0] FUNCTION;

	// Instantiate the Unit Under Test (UUT)
	PC_IM_RF_ALU_RTYPE uut (
		.CLK(CLK), 
		.RST(RST), 
		.ALU_Output_Top(ALU_Output_Top), 
		.ALU_Overflow(ALU_Overflow), 
		.ALU_Zero(ALU_Zero), 
		.ALU_Input_1(ALU_Input_1), 
		.ALU_Input_2(ALU_Input_2), 
		.ALU_Select_Status(ALU_Select_Status), 
		.REG_INPUT(REG_INPUT),
		.BRANCH_SIGNAL(Branch_Signal),
		.Counter(Counter),
		.Instruct(Instruct),
		.OPCODE(OPCODE),
		.RS(RS),
		.RT(RT),
		.RD(RD),
		.IMM(IMM),
		.FUNCTION(FUNCTION)
	);
	
			always
		#10 CLK = !CLK;

	initial begin
		// Initialize Inputs
		CLK = 0;
		RST = 0;

		// Wait 100 ns for global reset to finish
		#200; RST = 1; #20; RST = 0; #600; $finish;
        
		// Add stimulus here

	end
      
endmodule

