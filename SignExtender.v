`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Travis Aubrey
// RED ID: 814041534
//
// Description: Simple Sign Extender to make a 16 bit signal into a 32 bit signal
//////////////////////////////////////////////////////////////////////////////////
module SignExtender(
    input [15:0] SE_Input,
    output [31:0] SE_Output
    );

assign SE_Output = {16'b0, SE_Input};

endmodule
