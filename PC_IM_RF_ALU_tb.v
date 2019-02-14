`timescale 1ns / 1ps


module PC_IM_RF_ALU_tb;

	// Inputs
	reg CLK;
	reg RST;
	reg RF_Write_Enable_Flag;

	// Outputs
	wire [31:0] ALU_Output_Top;

	// Instantiate the Unit Under Test (UUT)
	PC_IM_RF_ALU_RTYPE uut (
		.CLK(CLK), 
		.RST(RST), 
		.RF_Write_Enable_Flag(RF_Write_Enable_Flag), 
		.ALU_Output_Top(ALU_Output_Top)
	);
	
		always
		#10 CLK = !CLK;

	initial begin
		// Initialize Inputs
		$monitor("At %d: ALU-Output = %b", $time, ALU_Output_Top);
		CLK = 0;
		RST = 1;
		RF_Write_Enable_Flag = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

