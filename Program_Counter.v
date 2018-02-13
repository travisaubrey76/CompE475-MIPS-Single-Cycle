`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Travis Aubrey
// Red ID: 814041534
//
// Description: 32-bit Program Counter Module that will be universally incorporated
// 				 in future builds.
//
// Working? Yes, as far as I know.
//////////////////////////////////////////////////////////////////////////////////
module Program_Counter(
	 input CLK, RST,
    output reg [31:0] OUT
    );

always @(posedge CLK) begin
	if(RST == 1) begin
		OUT <= 32'b0;
	end
	else begin
		OUT <= OUT + 1;
	end
end
endmodule
