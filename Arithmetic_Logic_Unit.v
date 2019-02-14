`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Travis Aubrey
// Red ID: 814041534
//
// Description: 32-bit ALU - Right now, it's a basic ALU, but I need to figure
//					 out a way to intuitively associate an overflow flag.
//
//////////////////////////////////////////////////////////////////////////////////
module Arithmetic_Logic_Unit #(parameter WL = 32,
													  SEL = 3)
	(input signed [WL - 1:0] ALU_In1,
    input signed [WL - 1:0] ALU_In2,
    input [SEL - 1:0] ALU_Sel,
    output ALU_Overflow_Flag,
    output reg ALU_Zero_Flag,
    output reg signed [31:0] ALU_Output
    );
	 
	 wire [WL:0] tmp;
	 
	 assign tmp = {1'b0,ALU_In1} + {1'b0,ALU_In2}; //Extending the input bits to WL + 1 so that I can see if the final bit is overflowing
	 assign ALU_Overflow_Flag = tmp[WL]; //If there is a bit in this location then the addition would have overflowed

always @(*) begin //Believe we need the ALU to work via combi logic
	case(ALU_Sel) //Control Unit will be reading the OP codes and sending them here
	
		3'b010: begin //Addition Operation
			ALU_Output = ALU_In1 + ALU_In2;
			ALU_Zero_Flag = (ALU_Output == 32'b0);
		end
		
		3'b110: begin //Subtraction Operation
			ALU_Output = ALU_In1 - ALU_In2;
			ALU_Zero_Flag = (ALU_Output == 32'b0); //Asserted if output is zero
		end
		
		3'b000: begin //AND Operation
			ALU_Output = ALU_In1 && ALU_In2;
			ALU_Zero_Flag = (ALU_Output == 32'b0); //Asserted if output is zero
		end
		
		3'b001: begin //OR Operation
			ALU_Output = ALU_In1 || ALU_In2;
			ALU_Zero_Flag = (ALU_Output == 32'b0); //Asserted if output is zero
		end
		
		3'b111: begin //SET LESS THAN OPERATION?
			if(ALU_In1 < ALU_In2) begin
				ALU_Output = 1;
			end
			else begin
				ALU_Output = 0;
			end
			ALU_Zero_Flag = (ALU_Output == 32'b0); //Asserted if output is zero
		end
		
		3'b100: begin //LUI called, Shifting ALU_Input2 left 16 bits and sending it to out.
			ALU_Output = ALU_In2 << 16;
			ALU_Zero_Flag = (ALU_Output == 32'b0);
		end
		
		3'b011: begin //SLLV called, Shifting ALU_In1 left ALU_In2 bits and sending it to out.
			ALU_Output = ALU_In1 << ALU_In2;
			ALU_Zero_Flag = (ALU_Output == 32'b0);
		end
		
		default: begin //Just having the default be addition unsigned
			ALU_Output = ALU_In1 + ALU_In2;
			ALU_Zero_Flag = (ALU_Output == 32'b0);
		end

	endcase
end

endmodule
