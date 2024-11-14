/*
Unidad Aritmético Lógica: es un circuito digital que calcula operaciones 
aritméticas (suma, resta, multiplicación, etc.), lógicas (AND, OR, NOT, XOR) 
y comparaciones para los saltos condicionales entre los operandos. .
*/


module ALU(
    input wire [31:0]   srcA,
    input wire [31:0]   srcB,
    input wire [2:0]    ALUControl,
    output reg [31:0]   zero,   //devuelve siempre zero 
    output reg [31:0]   res   
);

reg [31:0] res0;

always @(*) 
    begin  
        zero <= 32'h00000000;
        case (ALUControl)
            3'b000: //suma
                res0 = srcA + srcB;
            3'b001: //resta
                res0 = srcA - srcB;
            3'b010: //and
                res0 = srcA && srcB;
            3'b011: //or
                res0 = srcA || srcB;
            3'b100: //set less than
                res0 = (srcA >srcB ? srcA : srcB);
            default: // do nothing
                res0=srcA;    
        endcase                
    
        res <= res0;  
    end

endmodule