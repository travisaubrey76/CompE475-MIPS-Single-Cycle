`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
////////////////////////////////////////////////////////////////////////////////

module DM_tb;

	// Inputs
	reg [31:0] DM_Input_Address;
	reg [31:0] DM_Data_To_Write;
	reg DM_Write_Enable_Flag;
	reg CLK;

	// Outputs
	wire [31:0] DM_Output_Data;

	// Instantiate the Unit Under Test (UUT)
	Data_Memory uut (
		.DM_Input_Address(DM_Input_Address), 
		.DM_Data_To_Write(DM_Data_To_Write), 
		.DM_Write_Enable_Flag(DM_Write_Enable_Flag), 
		.CLK(CLK), 
		.DM_Output_Data(DM_Output_Data)
	);

	always
		#10 CLK = !CLK;

	initial begin
		// Initialize Inputs
		$monitor("At %d: DM-Output = %b", $time, DM_Output_Data);
		DM_Input_Address = 0;
		DM_Data_To_Write = 0;
		DM_Write_Enable_Flag = 0;
		CLK = 1;

		// Wait 100 ns for global reset to finish
		#40;
        
		// Add stimulus here
		DM_Input_Address = 1; #10;
		DM_Input_Address = 2; #20;
		DM_Write_Enable_Flag = 1; DM_Data_To_Write = 7; #20
		DM_Write_Enable_Flag = 0; #20
		DM_Input_Address = 0; #20;
		$finish;
	end
      
endmodule

