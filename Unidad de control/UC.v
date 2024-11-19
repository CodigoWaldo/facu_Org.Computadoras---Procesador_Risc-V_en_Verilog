`include "../Unidad de control/Main_Deco/mainDeco.v"
`include "../Unidad de control/Alu_deco/AluDeco.v"

module UC(
    input [6:0]     op,         // Código de operación (opcode)
    input [2:0]     f3,         // Campo f3
    input [6:0]     f7,         // Campo f7
    input    zero,        // Señal de cero (resultado de comparación)
    
    output wire     pcSrc,       // Señal hacia el multiplexor 2x1
    output [1:0]    resultSrc,  // Fuente del resultado
    output wire     memWrite,    // Señal de escritura en memoria
    output wire     aluSrc,      // Señal de fuente para la ALU
    output [1:0]    immSrc,     // Fuente del inmediato
    output wire     regWrite,    // Señal de escritura en el registro
    output [2:0]    aluControl,  // Salida de control para la ALU
    output  wire    jump  // Salida de control para la ALU
);

wire [1:0] aluOp; 

// Instancia del deco principal
main_deco m_deco_inst( 
    op,
    branch, jump, resultSrc, memWrite, aluSrc, immSrc, regWrite, aluOp      
);

// Instancia del deco ALU
alu_deco alu_deco_inst(
    op, f7, f3, aluOp,
    aluControl
);

// Lógica combinacional para pcSrc
assign pcSrc = (zero & branch) | jump;

endmodule
