`include "alu_deco/aluDeco.v"
`include "main_deco/mainDeco.v"

module control_unit(
    input [6:0] op,         // opcode
    input [2:0] f3,         // f3
    input [6:0] f7,         // f7
    output wire branch,     // branch signal
    output wire jump,       // jump signal
    output [1:0] resSrc,    // result source
    output wire memWrite,   // memory write signal
    output wire aluSrc,     // ALU source signal
    output [1:0] immSrc,    // immediate source
    output wire regWrite,   // register write signal
    output [2:0] aluControl // ALU control output
);
