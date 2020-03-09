module PipeEtoM(input logic clk, reset, RegWriteE, MemtoRegE, MemWriteE, BranchE, Zero,
                input logic[31:0] ALUOut,
                input logic [31:0] WriteDataE,
                input logic[4:0] WriteRegE,
                input logic[31:0] PCBranchE,
                    output logic RegWriteM, MemtoRegM, MemWriteM, BranchM, ZeroM,
                    output logic[31:0] ALUOutM,
                    output logic [31:0] WriteDataM,
                    output logic[4:0] WriteRegM,
                    output logic[31:0] PCBranchM);
    
    always_ff @(posedge clk, posedge reset) begin
        // ******************************************************************************
        if (reset)
		begin
		RegWriteM <= 0;
		MemWriteM <= 0;
		MemtoRegM <= 0;
		BranchM <= 0;
		ZeroM <= 0;
		ALUOutM <= 0;
		WriteDataM <= 0;
		WriteRegM <= 0;
		PCBranchM <= 0;
		end

	else
		begin
		RegWriteM <= RegWriteE;
		MemWriteM <= MemWriteE;
		MemtoRegM <= MemtoRegE;
		BranchM <= BranchE;
		ZeroM <= Zero;
		ALUOutM <= ALUOut;
		WriteDataM <= WriteDataE;
		WriteRegM <= WriteRegE;
		PCBranchM <= PCBranchE;
		end
	//******************************************************************************
    end
endmodule