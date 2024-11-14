`include "..Alu_deco/AluDeco.v"
`include "..main_deco/mainDeco.v"

module UC(
    input [6:0] op,         // opcode
    input [2:0] f3,         // f3
    input [6:0] f7,         // f7
    input wire zero,

    output wire branch,     // branch signal
    output wire jump,       // jump signal
    output [1:0] resultSrc,    // result source
    output wire memWrite,   // memory write signal
    output wire aluSrc,     // ALU source signal
    output [1:0] immSrc,    // immediate source
    output wire regWrite,   // register write signal
    output [2:0] aluControl // ALU control output
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