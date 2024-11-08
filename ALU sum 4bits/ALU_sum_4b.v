//Modulo que suma 4bits a un valor de 32 bits.

module DM(
    input wire [31:0]   srcA,      
    output reg [31:0]   res     
);

reg [31:0] res0;

always @(*) 
    begin   
        res0 = srcA + 32'd4;
        res <= res0;  
    end

endmodule