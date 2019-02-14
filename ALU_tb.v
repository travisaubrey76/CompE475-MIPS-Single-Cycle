`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:55:19 02/21/2018
// Design Name:   Arithmetic_Logic_Unit
// Module Name:   /home/ise/Compe475/SingleCycleProcessor/ALU_tb.v
// Project Name:  SingleCycleProcessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Arithmetic_Logic_Unit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_tb;

	// Inputs
	reg [31:0] ALU_In1;
	reg [31:0] ALU_In2;
	reg [2:0] ALU_Sel;

	// Outputs
	wire ALU_Overflow_Flag;
	wire ALU_Zero_Flag;
	wire [31:0] ALU_Output;

	// Instantiate the Unit Under Test (UUT)
	Arithmetic_Logic_Unit uut (
		.ALU_In1(ALU_In1), 
		.ALU_In2(ALU_In2), 
		.ALU_Sel(ALU_Sel), 
		.ALU_Overflow_Flag(ALU_Overflow_Flag), 
		.ALU_Zero_Flag(ALU_Zero_Flag), 
		.ALU_Output(ALU_Output)
	);

	initial begin
		// Initialize Inputs
		ALU_In1 = 10;
		ALU_In2 = 20;
		ALU_Sel = 3'b010;

		// Wait 100 ns for global reset to finish
		#100;
		
		ALU_In1 = 105;
		ALU_In2 = 210;
		#100;
		
		ALU_In1 = -100;
		ALU_In2 = 200;
		#100;
		
		ALU_In1 = 100;
		ALU_In2 = -200;
		#100;
		
		$finish;
        
		// Add stimulus here

	end
      
endmodule

