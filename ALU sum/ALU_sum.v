//Modulo que suma 2 valores de de 32 bits.

module DM(
    input wire [31:0]   srcA,
    input wire [31:0]   srcB,    
    output reg [31:0]   res     
);

reg [31:0] res0;

always @(posedge clk) 
    begin   
        res0 = srcA + srcB;
        res <= res0;  
    end

endmodule