`timescale 1ns / 1ps

//Simple Multiplexer
module Multiplexer #(parameter INPUTA = 32,
										 INPUTB = 32,
										 OUTPUT = 32)
	 (
    input [INPUTA - 1:0] Mux_In_A,
    input [INPUTB - 1:0] Mux_In_B,
	 input SEL,
    output reg[OUTPUT - 1:0] Mux_Out
    );

always @* begin
	if(SEL)
		Mux_Out <= Mux_In_B;
	else
		Mux_Out <= Mux_In_A;
end

endmodule
