module PipeDtoE(input logic clr, clk, reset, RegWriteD, MemtoRegD, MemWriteD, // FLUSH e will be connected to this clr
                input logic[2:0] AluControlD,
                input logic AluSrcD, RegDstD, BranchD,
                input logic[31:0] RD1D, RD2D,
                input logic[4:0] RsD, RtD, RdD,
                input logic[31:0] SignImmD,
                input logic[31:0] PCPlus4D,
                    output logic RegWriteE, MemtoRegE, MemWriteE,
                    output logic[2:0] AluControlE,
                    output logic AluSrcE, RegDstE, BranchE,
                    output logic[31:0] RD1E, RD2E,
                    output logic[4:0] RsE, RtE, RdE,
                    output logic[31:0] SignImmE,
                    output logic[31:0] PCPlus4E);

    always_ff @(posedge clk, posedge reset)begin
        // ******************************************************************************
        if (reset || clr)
		begin
		RsE <= 0;
		RtE <= 0;
		RdE <= 0;
		RegWriteE <= 0;
		MemWriteE <= 0;
		MemtoRegE <= 0;
		BranchE <= 0;
		AluControlE <= 0;
		AluSrcE <= 0;
		RegDstE <= 0;
		RD1E <= 0;
		RD2E <= 0;
		SignImmE <= 0;
		PCPlus4E <= 0;
		end
//A more  efficient clr
	//else if(clr)
		//begin
		//RsE <= 0;
		//RtE <= 0;
		//RdE <= 0;
		//RegWriteE <= 0;
		//MemWriteE <= 0;
		//BranchE <= 0; //no branch was coming in
		//end
//Normal Case:
	else	
		begin
		RsE <= RsD;
		RtE <= RtD;
		RdE <= RdD;
		RegWriteE <= RegWriteD;
		MemWriteE <= MemWriteD;
		MemtoRegE <= MemtoRegD;
		AluControlE <= AluControlD ;
		AluSrcE <= AluSrcD;
		RegDstE <= RegDstD;
		BranchE <= BranchD;
		RD1E <= RD1D;
		RD2E <= RD2D;
		SignImmE <= SignImmD;
		PCPlus4E <= PCPlus4D;
		end
        // ******************************************************************************
    end
endmodule