`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Travis Aubrey
// Red ID: 814041534
//
// Description: Make Sure the Depth is parametric
//////////////////////////////////////////////////////////////////////////////////
module Instruction_Memory #(parameter MEMORY_WIDTH = 32,
												  MEMORY_DEPTH = 50)
	(input [31:0] IM_Input_Address,
    output [31:0] IM_Output_Address
    );
	 
	 reg [MEMORY_WIDTH - 1: 0] instruction_memory [MEMORY_DEPTH-1:0];
	 
initial begin //initialize the 
	$readmemb("InstructionMemoryInit.txt", instruction_memory);
end

//Going to try and implement this the same as my Register File
assign IM_Output_Address = memory[IM_Input_Address];

endmodule
