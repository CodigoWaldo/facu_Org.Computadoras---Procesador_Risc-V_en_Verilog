/*
Unidad Aritmético Lógica: es un circuito digital que calcula operaciones 
aritméticas (suma, resta, multiplicación, etc.), lógicas (AND, OR, NOT, XOR) 
y comparaciones para los saltos condicionales entre los operandos. .
*/


module ALU(
    input wire [31:0]   srcA,
    input wire [31:0]   srcB,
    input wire [2:0]    ALUControl,
    output              zero,   //devuelve siempre zero 
    output reg [31:0]   res   
);

reg [31:0] res0;
wire [31:0] resta= srcA - srcB;
always @(*) 
    begin  
        case (ALUControl)
            3'b000: //suma
                res0 = srcA + srcB;
            3'b001: //resta
                res0 = srcA - srcB;
            3'b010: //and
                res0 = srcA & srcB;
            3'b011: //or
                res0 = srcA || srcB;
            3'b101: //set less than
                res0= (resta[31]==1'b1)? 32'h00000001: 32'h0000;
            default: // do nothing
                res0=srcA;    
        endcase                
    
        res <= res0;  
    end

    assign zero = (res0 == 32'b0)? 1'b1 : 1'b0;

endmodule