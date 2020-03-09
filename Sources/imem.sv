module imem ( input logic [5:0] addr, output logic [31:0] instr);

// imem is modeled as a lookup table, a stored-program byte-addressable ROM
	always_comb
	   case ({addr,2'b00})		   	// word-aligned fetch
//
// 	***************************************************************************
//	Here, you should paste the test cases that are given to you in lab document.
//  You can write your own test cases and try it as well.
//	Below is the program from the single-cycle lab.
//	***************************************************************************
//
//		address		instruction
//		-------		-----------


//No error (lab5) 
//        8'h00: instr = 32'h20080007;
//        8'h04: instr = 32'h20090005;
//        8'h08: instr = 32'h200a0000;
//        8'h0c: instr = 32'h210b000f;
//        8'h10: instr = 32'h01095020;
//        8'h14: instr = 32'h01095025;
//        8'h18: instr = 32'h01095024;
//        8'h1c: instr = 32'h01095022;
//        8'h20: instr = 32'h0109502a;
//        8'h24: instr = 32'had280002;
//        8'h28: instr = 32'h8d090000;
//        8'h2c: instr = 32'h1100fff5;
//        8'h30: instr = 32'h200a000a;
//        8'h34: instr = 32'h2009000c;



    //compute use hazard
//    8'h00: instr = 32'h20080005;  	
//    8'h04: instr = 32'h21090006;      
//    8'h08: instr = 32'h01285020;

//    //load use hazard
//    8'h00: instr = 32'h20080005;  	
//    8'h04: instr = 32'h20090006;      
//    8'h08: instr = 32'h20040001;      
//    8'h0c: instr = 32'h20050002;      
//    8'h10: instr = 32'had280000;
//    8'h14: instr = 32'h8d090001;
//    8'h18: instr = 32'h01245020;
//    8'h1c: instr = 32'h01255022;
    
    
//    //Branch Hazard
	  8'h00: instr = 32'h20090002;  	
    8'h04: instr = 32'h10000002;      
    8'h08: instr = 32'h20090005;      
    8'h0c: instr = 32'h21290006;      
    8'h10: instr = 32'h20090008;
    8'h14: instr = 32'h20040000;
    8'h18: instr = 32'h20050000;
    8'h1c: instr = 32'hac090000;    
        
        

        
        
// (lab 4) 
//		8'h00: instr = 32'h20020005;  	
//		8'h04: instr = 32'h2003000c;  	
//		8'h08: instr = 32'h2067fff7;  	
//		8'h0c: instr = 32'h00e22025;  	
//		8'h10: instr = 32'h00642824;
//		8'h14: instr = 32'h00a42820;
//		8'h18: instr = 32'h10a7000a;
//		8'h1c: instr = 32'h0064202a;
//		8'h20: instr = 32'h10800001;
//		8'h24: instr = 32'h20050000;
//		8'h28: instr = 32'h00e2202a;
//		8'h2c: instr = 32'h00853820;
//		8'h30: instr = 32'h00e23822;
//		8'h34: instr = 32'hac670044;
//		8'h38: instr = 32'h8c020050;
//		8'h3c: instr = 32'h08000011;
//		8'h40: instr = 32'h20020001;
//		8'h44: instr = 32'hac020054;
//		8'h48: instr = 32'h08000012;	// j 48, so it will loop here
	     default:  instr = {32{1'bx}};	// unknown address
	   endcase
endmodule