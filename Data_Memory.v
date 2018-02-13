`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Travis Aubrey
// Red ID: 814041534
//
// Description: Help for write-first mode taken from page 111 of textbook. But that ended up being wrong...
//
// Working? Yes.
//////////////////////////////////////////////////////////////////////////////////
module Data_Memory #(parameter WL = 32, 
										 MEMORY_WIDTH = 32,
										 MEMORY_DEPTH = 50)

	(input [WL-1:0] DM_Input_Address,
    input [MEMORY_WIDTH-1:0] DM_Data_To_Write,
    input DM_Write_Enable_Flag,
    input CLK,
	 output[MEMORY_WIDTH-1:0] DM_Output_Data
    );

	reg [MEMORY_WIDTH - 1: 0] data_memory [MEMORY_DEPTH-1:0];
	//reg [MEMORY_DEPTH - 1: 0] addrq;

initial begin //initialize the 
	$readmemb("DataMemoryInit.txt", data_memory);
end

always @(posedge CLK) begin
	if(DM_Write_Enable_Flag)
		data_memory[DM_Input_Address] <= DM_Data_To_Write;
		//Not a part of the above if statement since we want this to happen all the time
		//addrq <= DM_Input_Address;
end

assign DM_Output_Data = data_memory[DM_Input_Address];

endmodule
