`include "../Datapath/datapath.v"
`include "../Unidad de control/UC.v"

module procesador (
    input wire clk,
    input wire reset    // Señal de reset
        
);

//Declaración de todas las variables a utilizar
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
wire        zero;
wire [4:0]  addressDM;
wire [31:0] wd;
wire [31:0] dm_Result;    

// Instancia del datapath
datapath datapath_inst (
    .clk(clk),
    .reset(reset),
    .pcSrc(pcSrc), 
    .resultSrc(resultSrc), 
    .aluSrc(aluSrc), 
    .immSrc(immSrc), 
    .regWrite(regWrite), 
    .aluControl(aluControl),
    .f7(f7), 
    .f3(f3), 
    .op(op), 
    .zero(zero),
    .dm_Result(dm_Result),
    .wd(wd),
    .addressDM(addressDM)
);

// Instancia de la unidad de control
UC UC_inst (
    .op(op), 
    .f3(f3), 
    .f7(f7), 
    .zero(zero),
    .pcSrc(pcSrc), 
    .resultSrc(resultSrc), 
    .aluSrc(aluSrc), 
    .immSrc(immSrc), 
    .regWrite(regWrite), 
    .aluControl(aluControl),
    .memWrite(memWrite) 

);
// Instancia de memoria de datos
DM DM_inst(                             
    clk, addressDM, wd, memWrite,   //inputs
    dm_Result                       //output
);


endmodule