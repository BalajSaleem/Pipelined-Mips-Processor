	// ********************************************************************
	// Below, instantiate a controller and a datapath with their new (if modified) 
	// signatures and corresponding connections.
    // Also, you might want to instantiate PipeWtoF and pcsrcmux here.
    // Note that this is not the only solution.
    // You can do it in your way as long as it works.
	// ********************************************************************

module mips (input  logic        clk, reset,
             output logic[31:0]  PCF,
             input  logic[31:0]  instr,
             output logic[31:0]  aluout, resultW,
             output logic[31:0]  instrOut, WriteDataM,
             output logic StallD, StallF,
             output logic[31:0]  SrcAE,SrcBE,
             output logic [1:0] ForwardAE, ForwardBE,
             output logic[4:0] WriteRegW,
             output logic RegDstE,
             output logic[4:0] RtE, RdE,
             output logic MemWriteM,
             input logic[31:0] ReadDataM,
             output logic RegWriteW,
             output logic FlushE
             );

    // ********************************************************************
    // You can change the logics below but if you didn't change the signitures of 
    // above modules you will need these.
    // ********************************************************************

    logic memtoreg, zero, alusrc, regdst, regwrite, jump, PCSrcM, branch, memwrite;
    //logic [31:0] PCm, PCBranchM, instrD;
    logic [31:0] PCPlus4F, PCm, PCBranchM, instrD;
    logic [2:0] alucontrol;
    assign instrOut = instr;
    
    //logic [2:0] ALUControlD;
    logic [31:0] PC;// ResultW; temp logic for W to F pipe

    //PCsrcM comes from Datapath
    datapath dp(clk, reset,PCF, instr,regwrite, memtoreg, memwrite,
    alucontrol,alusrc,regdst, branch,
    //outputs
    PCSrcM, StallD, StallF,PCBranchM,
    PCPlus4F, instrD, aluout, resultW, WriteDataM,SrcAE,SrcBE, ForwardAE,
    ForwardBE,WriteRegW,RegDstE,RtE, RdE,MemWriteM,  ReadDataM,RegWriteW,FlushE);
    
    controller cnt(instrD[31:26], instrD[5:0],memtoreg, memwrite,alusrc,
    regdst, regwrite,jump,alucontrol,branch);
    //fetch and its stuff
    mux2 #(32) pcsrcmux(PCPlus4F,PCBranchM,PCSrcM,PC);
    PipeWtoF wtf(PC,~StallF,clk, reset,PCF);
    //
    
    
endmodule