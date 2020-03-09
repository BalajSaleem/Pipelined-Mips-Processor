// Hazard Unit with inputs and outputs named
// according to the convention that is followed on the book.

module HazardUnit( input logic RegWriteW,
                input logic [4:0] WriteRegW,
                input logic RegWriteM,MemToRegM,
                input logic [4:0] WriteRegM,
                input logic RegWriteE,MemtoRegE,Branch,
                input logic [4:0] rsE,rtE,
                input logic [4:0] rsD,rtD,
                output logic [1:0] ForwardAE,ForwardBE,
                output logic FlushE,StallD,StallF);
   
    logic lwstall;
    always_comb begin
    
        // ********************************************************************
        // Here, write equations for the Hazard Logic.
        // If you have troubles, please study pages ~420-430 in your book.
        // ********************************************************************
	
	logic lwstall;
	logic branchstall;    	
	if ( ( rsE !=0 ) && ( rsE == WriteRegM )  && RegWriteM )
	ForwardAE = 10;
	else if ( ( rsE !=0 ) && ( rsE == WriteRegW )  && RegWriteW )
	ForwardAE = 01;
	else
	ForwardAE = 00;

	if( ( rtE !=0 ) && ( rtE == WriteRegM )  && RegWriteM )
	ForwardBE = 10;
	else if( ( rtE !=0 ) && ( rtE == WriteRegW )  && RegWriteW )
	ForwardBE = 01;
	else
	ForwardBE = 00;
	
	lwstall = ( ( rsD == rtE ) || ( rtD == rtE ) ) && MemtoRegE;

	StallF = lwstall | Branch;
	StallD = lwstall | Branch;
	FlushE = lwstall | Branch;

    end

endmodule