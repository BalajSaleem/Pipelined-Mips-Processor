`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2019 11:13:10 AM
// Design Name: 
// Module Name: topest
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


module topest(
input logic clk, btn1, btn2,
output logic[6:0] seg,
output logic[3:0] an,
output logic dp,memwrite,regwrite,flush,stallD,stallF,regdst
);

    logic[1:0] forwardAE, forwardBE;
    logic[31:0] aluout, resultW, pc, instr;
    logic handclk,reset;//,dp, memwrite;
    //logic[6:0] seg;
    //logic[3:0] an;
    //procesor
    top mipser(handclk, reset,aluout, resultW, pc, instr,forwardAE, forwardBE, memwrite,
    regwrite,flush,stallD,stallF,regdst);
     //instantiale pulse and display controllers
   // display_controller disp(clk, reset,4'b1111,4'hf,4'hf,4'hf,4'hf,an,seg,dp);
      display_controller disp(clk, reset,4'b1111,aluout[7:4],aluout[3:0],resultW[7:4],resultW[3:0],an,seg,dp);

    pulse_controller puls(clk,btn1,0, handclk);
    pulse_controller puls2(clk,btn2,0, reset);
    
endmodule
