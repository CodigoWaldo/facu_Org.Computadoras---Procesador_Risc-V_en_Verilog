`include "../Datapath/datapath.v"
`include "../Unidad de control/UC.v"

module procesador (
    input wire clk,
    input wire reset    // Señal de reset
    //input wire reset, ? (si es necesario agregar reset, puedes hacerlo aquí)
);
wire        pcSrc;
wire [1:0]  resultSrc;
wire        memWrite;
wire        aluSrc;
wire [1:0]  immSrc;
wire        regWrite;
wire [2:0]  aluControl;
wire [6:0]  op;
wire [6:0]  f7;
wire [2:0]  f3;
wire [31:0] zero;

// Instancia del datapath
datapath datapath_inst (
    .clk(clk), 
    .reset(reset),
    .pcSrc(pcSrc), 
    .resultSrc(resultSrc), 
    .memWrite(memWrite), 
    .aluSrc(aluSrc), 
    .immSrc(immSrc), 
    .regWrite(regWrite), 
    .aluControl(aluControl),
    .f7(f7), 
    .f3(f3), 
    .op(op), 
    .zero(zero)
);

// Instancia de la unidad de control
UC UC_inst (
    .op(op), 
    .f3(f3), 
    .f7(f7), 
    .zero(zero),
    .pcSrc(pcSrc), 
    .resultSrc(resultSrc), 
    .memWrite(memWrite), 
    .aluSrc(aluSrc), 
    .immSrc(immSrc), 
    .regWrite(regWrite), 
    .aluControl(aluControl)
);

endmodule