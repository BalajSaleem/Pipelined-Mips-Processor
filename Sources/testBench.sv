//timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2019 02:20:04 PM
// Design Name: 
// Module Name: testBench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testBench();
    logic clk, reset,MemWriteM;//memwrite;
    logic RegWriteW;
    logic[31:0] aluout, resultW,pc,instr;
    logic FlushE,StallD, StallF;
    logic RegDstE;
    logic[1:0] ForwardAE, ForwardBE;
    top dut(clk, reset, aluout, resultW,pc,instr,ForwardAE, ForwardBE,
    MemWriteM,RegWriteW,FlushE,StallD, StallF,RegDstE);
    
    initial begin
       clk = 1;
      reset = 1;
       
       #10
       reset = 0;
    end
    
    
    always
        #5 clk = ~clk;
        
endmodule
