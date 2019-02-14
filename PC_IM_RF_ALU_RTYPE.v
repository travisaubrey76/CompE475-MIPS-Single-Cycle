`timescale 1ns / 1ps

module PC_IM_RF_ALU_RTYPE( input CLK,
									input RST,
									
									output [31:0] ALU_Output_Top,
									output ALU_Overflow,
									output ALU_Zero,
									
									output [31:0] ALU_Input_1,
									output [31:0] ALU_Input_2,
									output [2:0] ALU_Select_Status,
									
									
									output [31:0] REG_INPUT,
									
									output BRANCH_SIGNAL,
									
									output [31:0] Counter,
									output [31:0] Instruct,
									
									output [5:0] OPCODE,
									output [4:0] RS,
									output [4:0] RT,
									output [4:0] RD,
									output [15:0] IMM,
									output [5:0] FUNCTION
								 );
	wire [31:0] pc_to_im, pc_branch, pcr, pc, PCp1, pc_jump,pc_jump_reg;
	wire [31:0] im_to_rf, rf_data1_to_alu, rf_data2_to_alu, alu_to_dm, se_to_alu, semux_to_alu, dm_to_rf, dm_mux_to_rf;
	
	wire [2:0] control_to_alu_select;
	wire alu_in_select, rf_we, dm_we, m_to_rf_sel, rfd_sel, branch_signal;
	
	wire [4:0] rfa_mux_to_rf;
	
	wire pc_sel, jump_from_cu, jr_select;
	
	and	AND1 (pc_sel, branch_signal, ALU_Zero);
	
									 
	Adder PCBEQ_ADDER (.A(se_to_alu),
							 .B(PCp1),
							 .OUT(pc_branch));
							 
	Multiplexer  MUX_PC_JR (.Mux_In_A(pc_jump),
									.Mux_In_B(alu_to_dm),
									.SEL(jr_select),
									.Mux_Out(pc_jump_reg));
	
		
	Program_Counter PC (.CLK(CLK),
							  .RST(RST),
							  .IN(pc_jump_reg),
							  .OUT(pc_to_im));
	
	Adder PCp1_ADDER (.A(pc_to_im),
							 .B(1),
							 .OUT(PCp1));
							 
	Multiplexer  MUX_PC_BEQ (.Mux_In_A(PCp1),
									 .Mux_In_B(pc_branch),
									 .SEL(pc_sel),
									 .Mux_Out(pc));
									 
	Multiplexer  MUX_PC_JUMP (.Mux_In_A(pc),
									 .Mux_In_B({PCp1[31:26], im_to_rf[25:0]}),
									 .SEL(jump_from_cu),
									 .Mux_Out(pc_jump));
							
	
	Instruction_Memory IM (.IM_Input_Address(pc_to_im), 
								  .IM_Output_Address(im_to_rf));
								  
	Control_Unit CU (.Instruction(im_to_rf[31:26]),
							.Funct(im_to_rf[5:0]),
							.RF_WRITE_ENABLE(rf_we),
							.DM_WRITE_ENABLE(dm_we),
							.MtoRFSEL(m_to_rf_sel),
							.Branch(branch_signal), 
							.ALUInSel(alu_in_select),
							.RFDSel(rfd_sel),
							.ALUsel(control_to_alu_select),
							.JUMP(jump_from_cu),
							.JR(jr_select));
	
	Register_File RF(.RF_Read_Address1(im_to_rf[25:21]), 
						  .RF_Read_Address2(im_to_rf[20:16]),
						  .RF_Write_Address(rfa_mux_to_rf),
						  .RF_Data_Address_Input(dm_mux_to_rf), 
						  .CLK(CLK),
						  .RF_Write_Enable_Flag(rf_we),
						  .RF_Data1(rf_data1_to_alu),
						  .RF_Data2(rf_data2_to_alu));
						  
	SignExtender SE (.SE_Input(im_to_rf[15:0]), 
						  .SE_Output(se_to_alu));
					// A, B
	Multiplexer MUX_ALU  (.Mux_In_A(rf_data2_to_alu), //Mux that feeds into ALU from RFD2 or SE
								 .Mux_In_B(se_to_alu), 
								 .SEL(alu_in_select), 
								 .Mux_Out(semux_to_alu));
						  
	Arithmetic_Logic_Unit ALU (.ALU_In1(rf_data1_to_alu),
										.ALU_In2(semux_to_alu),
										.ALU_Sel(control_to_alu_select),
										.ALU_Output(alu_to_dm),
										.ALU_Overflow_Flag(ALU_Overflow),
										.ALU_Zero_Flag(ALU_Zero));

	Data_Memory DM (.DM_Input_Address(alu_to_dm),
						 .DM_Data_To_Write(rf_data2_to_alu), 
						 .DM_Write_Enable_Flag(dm_we),
						 .CLK(CLK),
						 .DM_Output_Data(dm_to_rf));
						 
	Multiplexer  MUX_DM (.Mux_In_A(alu_to_dm),
								.Mux_In_B(dm_to_rf),
								.SEL(m_to_rf_sel),
								.Mux_Out(dm_mux_to_rf));
							  
	Multiplexer	#(5,5,5) MUX_RFA (.Mux_In_A(im_to_rf[20:16]),
											      .Mux_In_B(im_to_rf[15:11]),
													.SEL(rfd_sel),
													.Mux_Out(rfa_mux_to_rf));
										
										
										
	assign ALU_Output_Top = alu_to_dm;
	assign REG_INPUT = dm_mux_to_rf;
	
	assign ALU_Input_1 = rf_data1_to_alu;
	assign ALU_Input_2 = semux_to_alu;
	assign ALU_Select_Status = control_to_alu_select;
	
	assign BRANCH_SIGNAL = branch_signal;
	
	assign Counter = pc_to_im;
	assign Instruct = im_to_rf;
	
	assign OPCODE = im_to_rf[31:26];
	assign RS = im_to_rf[25:21];
	assign RT = im_to_rf[20:16];
	assign RD = im_to_rf[15:11];
	assign IMM = im_to_rf[15:0];
	assign FUNCTION = im_to_rf[5:0];
	
	

endmodule
