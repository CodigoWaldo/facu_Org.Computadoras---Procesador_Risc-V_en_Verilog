//Modulo que suma 4bits a un valor de 32 bits.

module ALU_sum_4b(
    input wire [31:0]   src,      
    output reg [31:0]   res     
);

reg [31:0] res0;

always @(*) 
    begin   
        res0 = src + 32'h0000004;
        res <= res0;  
    end

endmodule