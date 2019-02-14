`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
////////////////////////////////////////////////////////////////////////////////

module SE_tb;

	// Inputs
	reg [15:0] SE_Input;

	// Outputs
	wire [31:0] SE_Output;

	// Instantiate the Unit Under Test (UUT)
	SignExtender uut (
		.SE_Input(SE_Input), 
		.SE_Output(SE_Output)
	);

	initial begin
		// Initialize Inputs
		SE_Input = 16'b1111111111111111;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		SE_Input = 16'b1010101010101010;

	end
      
endmodule

