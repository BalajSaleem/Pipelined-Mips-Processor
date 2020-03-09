module top  (input   logic 	 clk,reset,          
	     output  logic[31:0] aluout, resultW, pc, instr, 
	     output logic [1:0] ForwardAE, ForwardBE,
	     //output logic[4:0] WriteRegW    ,
	     //output logic RegDstE    
	     //,output logic[4:0] RtE, RdE,
	     output logic MemWriteM,
	     output logic RegWriteW,
	     output logic FlushE, StallD, StallF,RegDstE
	     //output  logic memwrite
	     );
	     //output   logic[3:0] an,
	     //output  logic[6:0]  seg);
	     //output logic         bgtControl, bgtResult,pcsrc,branch,zero);  
   
   //logic     bgtControl, bgtResult,pcsrc,branch,zero;
   //logic[31:0] writedata, dataadr, pc, instr;
   logic[31:0]SrcAE,SrcBE;
   logic[4:0] WriteRegW;
   //logic RegDstE;
   logic[4:0] RtE, RdE;
   //logic [1:0] ForwardAE, ForwardBE;
   //take these to output for simulations
   logic [31:0] instrOut,WriteDataM,ReadDataM;//,jalrPc,pcplus4,jalWrite;
   //logic[4:0] jalAddr;    
   //logic jalrCntrl;
   
   
   // instantiate processor and memories  
   mips mips (clk, reset, pc, instr, aluout, resultW,
   instrOut,WriteDataM,StallD,StallF,SrcAE,SrcBE,ForwardAE, ForwardBE,WriteRegW,
   RegDstE,RtE, RdE,MemWriteM, ReadDataM,RegWriteW,FlushE);  
   imem imem (pc[7:2], instr);
   dmem   dm(clk, MemWriteM,aluout, WriteDataM,ReadDataM);  
   //dmem dmem (clk, memwrite, dataadr, writedata, readdata);


endmodule