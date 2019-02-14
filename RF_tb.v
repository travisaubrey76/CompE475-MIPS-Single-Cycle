`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// 
////////////////////////////////////////////////////////////////////////////////

module RF_tb;

	// Inputs
	reg [4:0] RF_Read_Address1;
	reg [4:0] RF_Read_Address2;
	reg [4:0] RF_Write_Address;
	reg [31:0] RF_Data_Address_Input;
	reg CLK;
	reg RF_Write_Enable_Flag;

	// Outputs
	wire [31:0] RF_Data1;
	wire [31:0] RF_Data2;

	// Instantiate the Unit Under Test (UUT)
	Register_File uut (
		.RF_Read_Address1(RF_Read_Address1), 
		.RF_Read_Address2(RF_Read_Address2), 
		.RF_Write_Address(RF_Write_Address), 
		.RF_Data_Address_Input(RF_Data_Address_Input), 
		.CLK(CLK), 
		.RF_Write_Enable_Flag(RF_Write_Enable_Flag), 
		.RF_Data1(RF_Data1), 
		.RF_Data2(RF_Data2)
	);
	
	integer i;
	
	always
		#10 CLK = !CLK;

	initial begin
		// Initialize Inputs
		RF_Read_Address1 = 0;
		RF_Read_Address2 = 0;
		RF_Write_Address = 0;
		RF_Data_Address_Input = 0;
		CLK = 0;
		RF_Write_Enable_Flag = 0;

		// Wait 10 ns for global reset to finish
		#100;
		
		//RF_Write_Enable_Flag = 1; RF_Write_Address = 10;RF_Data_Address_Input = 32'b10101010101010101010101010101010;
		
		for(i = 1; i < 32; i = i + 1) begin
        RF_Read_Address1 = i; 
		  RF_Read_Address2 = i;
		  #10;
		end
		// Add stimulus here
		

	end
      
endmodule

