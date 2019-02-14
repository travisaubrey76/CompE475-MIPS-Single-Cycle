`timescale 1ns / 1ps

module Load_Store_Word_Section_tb;

	// Inputs
	reg CLK;
	reg RST;
	reg [5:0] ALU_Sel;
	reg SE_MUX_SEL;
	reg RF_Write_Enable_Flag;

	// Outputs
	wire [31:0] ALU_Output_Top;
	wire ALU_Overflow;
	wire ALU_Zero;

	// Instantiate the Unit Under Test (UUT)
	PC_IM_RF_ALU_RTYPE uut (
		.CLK(CLK), 
		.RST(RST), 
		.ALU_SEL(ALU_SEL),
		.SE_MUX_SEL(SE_MUX_SEL), 
		.RF_Write_Enable_Flag(RF_Write_Enable_Flag), 
		.ALU_Output_Top(ALU_Output_Top), 
		.ALU_Overflow(ALU_Overflow), 
		.ALU_Zero(ALU_Zero)
	);
	
	always
		#10 CLK = !CLK;

	initial begin
		// Initialize Inputs
		CLK = 0;
		RST = 0;
		ALU_SEL = 6'b100000;
		SE_MUX_SEL = 1;
		RF_Write_Enable_Flag = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

