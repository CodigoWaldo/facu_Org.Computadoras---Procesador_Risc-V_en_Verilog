`include "..Alu_deco/AluDeco.v"
`include "..main_deco/mainDeco.v"

module UC(
    input [6:0] op,         // Código de operación (opcode)
    input [2:0] f3,         // Campo f3
    input [6:0] f7,         // Campo f7
    input wire zero,        // Señal de cero (resultado de comparación)

    output wire branch,     // Señal de bifurcación (branch)
    output wire jump,       // Señal de salto (jump)
    output [1:0] resultSrc, // Fuente del resultado
    output wire memWrite,   // Señal de escritura en memoria
    output wire aluSrc,     // Señal de fuente para la ALU
    output [1:0] immSrc,    // Fuente del inmediato
    output wire regWrite,   // Señal de escritura en el registro
    output [2:0] aluControl // Salida de control para la ALU
);

reg [1:0] aluOp;
main_deco m_deco_inst( //instancia del deco principal
    .op(op),

    .branch(branch),
    .jump(jump),
    .resultSrc(resultSrc),
    .memWrite(memWrite),
    .aluSrc(aluSrc),
    .imm_Src(imm_Src),
    .regWrite(regWrite),
    .aluOp(aluOp)
);

alu_deco alu_deco_inst(
    .op(op),
    .f7(f7),
    .f3(f3),
    .aluOp(aluOp),
    .aluControl(aluControl)

)