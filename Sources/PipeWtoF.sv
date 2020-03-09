
module PipeWtoF(input logic[31:0] PC,
                input logic EN, clk, reset,		// StallF will be connected as this EN
                output logic[31:0] PCF);
    
    always_ff @(posedge clk, posedge reset)begin
        if (reset)
            PCF <= 0;
        else if(EN) //if (EN) set an output to the respective input. else set it to itself
            begin
            PCF<=PC;
            end
        else 
            PCF <= PCF;
    end
endmodule