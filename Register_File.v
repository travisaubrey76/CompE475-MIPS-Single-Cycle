`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Travis Aubrey
// RED ID: 814041534
//
// Description: Will Read 32 bit instructions from a text file
//					 Main portion of this code was adapted from PAGE 115 of the textbook
//					 That centers around RF construction
//
// Working? Yes.
//
// Comments: I don't think I need to intialize values for this module since it will
//				 be filled via Load Word, etc
//////////////////////////////////////////////////////////////////////////////////

module Register_File #(parameter WL = 32,
											MEMORY_WIDTH = 32,
											MEMORY_DEPTH = 32,
											READ_INPUT_WIDTH = 5)
	(input [READ_INPUT_WIDTH - 1: 0] RF_Read_Address1, //1 read address's specifying 1/32 registers each as source operands
    input [READ_INPUT_WIDTH - 1: 0] RF_Read_Address2,
    input [READ_INPUT_WIDTH - 1: 0] RF_Write_Address,
    input [WL-1:0] RF_Data_Address_Input,
    input CLK,
    input RF_Write_Enable_Flag,
	 output [WL-1:0]RF_Data1, //1 32 bit output
    output [WL-1:0]RF_Data2  //2nd 32 bit output for a total of 32 bits
    );
	 
	 reg [MEMORY_WIDTH - 1: 0] register_file_memory [MEMORY_DEPTH-1:0];
	 
//initial begin //initialize the 
//	$readmemb("RegInit.txt", memory);
//end

always @(posedge CLK) begin
	//Write First Mode if Write Enable is Active HIGH
	if(RF_Write_Enable_Flag)
		register_file_memory[RF_Write_Address] <= RF_Data_Address_Input;
end

//Think about using assign to read from memory here too! [PAGE 115]
assign RF_Data1 = register_file_memory[RF_Read_Address1];
assign RF_Data2 = register_file_memory[RF_Read_Address2];

endmodule
