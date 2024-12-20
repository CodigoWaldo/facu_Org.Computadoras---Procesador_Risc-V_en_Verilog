//Modulo que suma 2 valores de de 32 bits.

module  ALU_sum(
    input wire [31:0]   srcA,
    input wire [31:0]   srcB,    
    output wire [31:0]   res     
);

reg [31:0] res0;

always @(*) 
    begin   
        res0 = srcA + srcB;  
    end
assign res = res0;

endmodule