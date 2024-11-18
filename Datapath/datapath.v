/*
Camino de datos: Conexiones que relacionan los distintos 
modulos para conformar el procesador.
*/

//Unidad de control
`include "Unidad de control/UC.v"
//Memorias
`include "Memoria de datos/DM.v"     
`include "Mem de instrucciones/IM.v" 
`include "Banco de registro/BR.v" 
//multiplexores
`include "Multiplexor 2x1/MP_2x1.v"         
`include "Multiplexor 3x1/MP_3x1.v"
//ALU y Sumadores
`include "ALU/ALU.v"  
`include "ALU sum/ALU_sum.v"             //suma el binario de dos entradas
`include "ALU sum 4bits/ALU_sum_4b.v"    //suma 4 bits a una entrada (pc next)
//otros
`include "Extensor de signo/SE.v"
`include "Reg contador de programa/PC.v"

module datapath (
    input wire clk,
    input wire pcSrc,     // Señal de bifurcación (branch)
    input [1:0] resultSrc, // Fuente del resultado
    input wire memWrite,   // Señal de escritura en memoria
    input wire aluSrc,     // Señal de fuente para la ALU
    input [1:0] immSrc,    // Fuente del inmediato
    input wire regWrite,   // Señal de escritura en el registro
    input [2:0] aluControl // Salida de control para la ALU

    output [6:0] f7, //aca basicamente son las entradas
    output [2:0] f3, //de la unidad de control
    output [6:0] op,
    output zero

);
/*
Estructura de instancias de modulos:
  modulo instancia(
      inputs
      outputs
  );
*/

wire [31:0] pc;         //el adress de la instr actual
wire [31:0] pcNext;     //cuanto tengo q avanzar(si no hay pcSrc=0-> +4)
wire [31:0] instruction; //instr actual (a donde apunta el pc)
wire [4:0] a1           //rs1   (dato 1)
wire [4:0] a2           //rs2   (dato 2)
wire [4:0] a3           //rd    registro destino
wire [31:0] wd3         //palabra a guardar en el banco
wire [31:0] rd1         //palabra 1 leida del banco en a1
wire [31:0] rd2         //palabra 2 leida del banco en a2
wire [31:0] md_Result   //palabra leida desde la mem data


//--------------------- MEMORIAS

mem_instr mem_instr_inst(           //memoria de instrucciones okk
    pc[7:2], //le pido la instruccion que apunta el pc 
    instruction
 );

BR BR_inst(                         //BANCO DE REGISTROS ok
    clk, we, a1, a2, a3, wd3, 
    rd1, rd2
);

DM DM_inst(                         //memoria de datos ok
    clk, AluResult, rd2, memWrite,
    md_Result
);

//--------------------- PC (contador de programa) ok
PC PC_inst(
    clk, pc_next, 
    pc
);


//--------------------- SUMADORES
ALU_sum ALU_sum_inst(       //alu que suma el inm
    srcA, srcB, 
    res
);
//---------------------  MULTIPLEXORES
MP_2x1 mp_2x1_inst0(
    i1, i2, pcSrc, 
    pc_next
);

MP_2x1 mp_2x1_inst1( //ok
    rd2, inmExt, aluSrc,
    srcB
);

MP_2x1 mp_3x1_inst0(
    AluResult, md_Result, i3, selC, 
    out
);

//--------------------- ALU (la principal)
alu alu_inst( 
    srcA, srcB, ALUControl,
    zero, AluResult
);

//--------------------- EXTENSIÓN DE SIGNO on it
sign_ext sign_ext_inst(
    instruction[31:20], src,
    inmExt
);


endmodule