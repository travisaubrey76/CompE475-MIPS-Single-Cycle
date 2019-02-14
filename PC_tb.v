`timescale 1ns / 1ps

module PC_tb;

	// Inputs
	reg CLK;
	reg RST;
	reg PC_SEL;
	reg [31:0] JUMP;

	// Outputs
	wire [31:0] OUT;

	// Instantiate the Unit Under Test (UUT)
	Program_Counter uut (
		.CLK(CLK), 
		.RST(RST), 
		.PC_SEL(PC_SEL),
		.JUMP(JUMP),
		.OUT(OUT)
	);
	
	always
		#10 CLK = !CLK;

	initial begin
		// Initialize Inputs
		CLK = 0;
		RST = 0;
		PC_SEL = 0;
		JUMP = 100;

		// Wait 10 ns for global reset to finish <--- Necessary!
		#100;
        
		// Add stimulus here
		RST = 1; #20; RST = 0; #100; PC_SEL = 1; #100; $finish;

	end
      
endmodule

