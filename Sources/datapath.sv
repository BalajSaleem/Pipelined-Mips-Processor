
module datapath (input  logic clk, reset,
		         input logic [31:0] PCF, instr,	
		         input logic RegWriteD, MemtoRegD, MemWriteD,
		         input logic [2:0] ALUControlD,
		         input logic AluSrcD, RegDstD, BranchD,
		             output logic PCSrcM, StallD, StallF,
		             //output logic[31:0] PCBranchM, instrD, ALUOut, ResultW, WriteDataM); 
		             output logic[31:0] PCBranchM, PCPlus4F, instrD, ALUOut, ResultW, WriteDataM,SrcAE,SrcBE,
		             //output logic[31:0] WriteDataE,
		             output logic [1:0] ForwardAE, ForwardBE,
		             output logic[4:0] WriteRegW,
		             output logic RegDstE,
		             output logic[4:0] RtE, RdE,
		             //output logic[31:0] RD1E, RD2E,
		             output logic MemWriteM,
		             input logic[31:0] ReadDataM,
		             output logic RegWriteW,
		             output logic FlushE
		             ); 

	// ********************************************************************
	// Here, define the wires (logics) that are needed inside this pipelined datapath module
    // You are given the wires connecting the Hazard Unit.
    // Notice that StallD and StallF are given as output for debugging
	// ********************************************************************
	
	//experimental
    logic[31:0] RD1E, RD2E;
    logic[31:0] WriteDataE;
    
    
    
    
    //real
	logic ForwardAD, ForwardBD, ZeroE, ZeroM;
	logic RegWriteE, MemtoRegE, MemWriteE,AluSrcE, BranchE;
	logic RegWriteM, MemtoRegM,BranchM, MemtoRegW;
	logic [2:0] AluControlE;		
	// Add necessary wires (logics).
	logic [4:0] RsD, RtD, RdD, RsE, WriteRegE, WriteRegM;//WriteRegW, RtE, RdE,;
	logic [31:0] PCPlus4D,SignImmD, RD1D, RD2D,// RD1E, RD2E,// WriteDataE,//SrcBE,SrcAE,
	SrcBE1,AluOutE, SignImmE,PCPlus4E;
	logic [31:0] SignImmE2,PCBranchE, ALUOutM, ALUOutW, ReadDataW;
	// ********************************************************************
	// Instantiate the required modules below in the order of the datapath flow.
	// ********************************************************************
	
	assign PCSrcM = BranchM & ZeroM;
	assign RsD = instrD[25:21];
    assign RtD = instrD[20:16];
    assign RdD = instrD[15:11];
    
    adder adr(PCF, 32'h4,PCPlus4F);
    //assign WriteDataE = added down at a mux
    
	// Below, PipeFtoD and regfile instantiations are given
    // Add other instantiations
    // BE CAREFUL ABOUT THE ORDER OF PARAMETERS!
	
	
	//Decode Stuff and its pipe
	PipeFtoD ftd(instr, PCPlus4F, ~StallD, clk, reset, instrD, PCPlus4D); 
	     
	regfile rf (clk, RegWriteW, instrD[25:21], instrD[20:16],
            WriteRegW, ResultW, RD1D, RD2D);                                
	signext se (instrD[15:0], SignImmD);

	//Execute Stuff and its pipe
	
	PipeDtoE dte(FlushE, clk, reset, RegWriteD, MemtoRegD, MemWriteD,ALUControlD,
	AluSrcD, RegDstD, BranchD,RD1D, RD2D,RsD, RtD, RdD,SignImmD,PCPlus4D,
	//outputs
	RegWriteE, MemtoRegE, MemWriteE, AluControlE,AluSrcE, RegDstE, BranchE,RD1E, RD2E,RsE, RtE, 
	RdE,SignImmE,PCPlus4E);
	
	mux4 #(32)	    srcAEMux(RD1E,ResultW,ALUOutM,32'b0,ForwardAE,SrcAE);
	mux4 #(32)   	srcBEMux1(RD2E,ResultW,ALUOutM,32'b0,ForwardBE,WriteDataE);
	mux2 #(32)   	srcBEMux2(WriteDataE, SignImmE,AluSrcE, SrcBE);
	alu 		    alu(SrcAE, SrcBE,AluControlE,AluOutE,ZeroE, reset);
	mux2 #(5)	    WriteRegMux(RtE, RdE, RegDstE, WriteRegE);
	sl2         	immsh(SignImmE, SignImmE2);
	adder       	pcadd2(PCPlus4E, SignImmE2, PCBranchE);
	
	
	//Memory Stuff and its pipe
	assign ALUOut = ALUOutM;
	PipeEtoM etm(clk, reset, RegWriteE, MemtoRegE, MemWriteE, BranchE,
	 ZeroE,AluOutE,WriteDataE,WriteRegE,PCBranchE,
	 //outputs
	  RegWriteM, MemtoRegM, MemWriteM, BranchM, ZeroM,ALUOutM,WriteDataM,WriteRegM,PCBranchM);
	  
	  //assign PCSrcM = ; // done above
	  //dmem   dm(clk, MemWriteM,ALUOutM, WriteDataM,ReadDataM);
	 //WriteBack Stuff and its pipe  
	  PipeMtoW mtw(clk, reset, RegWriteM, MemtoRegM, ReadDataM, ALUOutM,
	  WriteRegM,
	  //outputs
	  RegWriteW, MemtoRegW,ReadDataW, ALUOutW,WriteRegW);
	  
	  //assign aluoutw =  ALUOutW;
	  
	  mux2 #(32) wbMux(ALUOutW,ReadDataW, MemtoRegW,ResultW);
	//Hazard Unit
	HazardUnit he(RegWriteW,WriteRegW,RegWriteM,MemtoRegM,WriteRegM,RegWriteE,MemtoRegE,
	PCSrcM,RsE,RtE,RsD,RtD,ForwardAE,ForwardBE,FlushE,StallD,StallF);

endmodule
