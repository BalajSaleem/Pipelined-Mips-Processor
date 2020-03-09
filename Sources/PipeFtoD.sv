module PipeFtoD(input logic[31:0] instr, PcPlus4F,
                input logic EN, clk, reset,		// ~StallD will be connected as this EN
                output logic[31:0] instrD, PcPlus4D);
    
    always_ff @(posedge clk, posedge reset)begin
        if (reset)begin
            instrD <= 0;
            PcPlus4D <= 0; //set outputs to zero
        end
        else if(EN)
            begin
            instrD<=instr; //the previously read instruction
            PcPlus4D<=PcPlus4F;
            end
        else begin
            instrD <= instrD;
            PcPlus4D <= PcPlus4D;
        end
    end
endmodule