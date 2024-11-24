//Memorias
`include "../Memoria de datos/DM.v"     
`include "../Mem de instrucciones/IM.v" 
`include "../Banco de registro/BR.v" 
//multiplexores
`include "../Multiplexor 2x1/MP_2x1.v"         
`include "../Multiplexor 3x1/MP_3x1.v"
//ALU y Sumadores
`include "../ALU/ALU.v"  
`include "../ALU sum/ALU_sum.v"             //suma el binario de dos entradas
`include "../ALU sum 4bits/ALU_sum_4b.v"    //suma 4 bits a una entrada (pc next)
//otros
`include "../Extensor de signo/SE.v"
`include "../Reg contador de programa/PC.v"

module datapath (
    input wire  clk,
    input wire reset,
    input wire  pcSrc,     // Señal de bifurcación o salto (branch o jal)
    
    input [1:0] resultSrc,// Fuente del resultado
    input wire  aluSrc,    // Señal de fuente para la ALU
    input [1:0] immSrc,   // Fuente del inmediato
    input wire  regWrite,  // Señal de escritura en el registro
    input [2:0] aluControl, // Salida de control para la ALU
    input [31:0] dm_Result,          //palabra leida desde la mem data

    output [4:0] addressDM,
    output [31:0] wd,        //palabra 2 leida del banco en a2[]
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
wire [31:0] pc;                 //el adress de la instr actual
wire [31:0] pcNext;             //cuanto tengo q avanzar(si no hay pcSrc=0-> +4)
wire [31:0] instruction;        //instr actual (a donde apunta el pc)
wire [4:0] a1 ;                 //rs1   (dato 1)
wire [4:0] a2 ;                 //rs2   (dato 2)
wire [4:0] a3 ;                 //rd    registro destino
wire [31:0] wd3;                //palabra a guardar en el banco
wire [31:0] rd1;                //palabra 1 leida del banco en a1
wire [31:0] rd2;                //palabra 2 leida del banco en a2
wire [31:0] pcPlusImm;          //pc al q se le suma un imm como salto
wire [31:0] AluResult;          //resultado de la alu pricipal
wire [31:0] immExt ;            //inmediato extendido por el SE
wire [31:0] pcPlus4 ;           //inmediato extendido por el SE
wire [31:0] srcB;               //entrada 2 de la alu

assign a1 = instruction[19:15];
assign a2 = instruction[24:20];
assign a3 = instruction[11:7];

assign f7 = instruction[31:25];
assign f3 = instruction[14:12];
assign op = instruction[6:0];
assign wd = rd2;
assign addressDM = AluResult[6:2];


//--------------------- MEMORIAS
mem_instr mem_instr_inst(               // memoria de instrucciones okk
    pc[6:2],                            // le pido la instruccion que apunta el pc 
    instruction
 );

BR BR_inst(                             // BANCO DE REGISTROS ok
    clk, regWrite, a1, a2, a3, wd3, 
    rd1, rd2
);

//--------------------- PC (contador de programa) ok
PC PC_inst(
    clk, reset, pcNext, 
    pc
);

//--------------------- SUMADORES
ALU_sum ALU_sum_inst(                   //alu que suma el inm al pc(por si hay salto) ok
    pc, immExt, 
    pcPlusImm
);

ALU_sum_4b ALU_sum_4b_inst(             //me da la siguiente instr sin salto ok
    pc,
    pcPlus4
);

//---------------------  MULTIPLEXORES

MP_2x1 mp_2x1_inst0(                    //decide si el pc_next es +4 o hay salto ok
    pcPlus4, pcPlusImm, pcSrc, 
    pcNext
);

MP_2x1 mp_2x1_inst1(                    // ok
    rd2, immExt, aluSrc,  
    srcB
);

MP_3x1 mp_3x1_inst0(                    // ok
    AluResult, dm_Result, pcPlus4, resultSrc, 
    wd3
);

//--------------------- ALU (la principal)
ALU alu_inst( 
    rd1, srcB, aluControl,
    zero, AluResult
);

//--------------------- EXTENSIÓN DE SIGNO on it
SE sign_ext_inst(
    instruction[31:7], immSrc,
    immExt //inmediato extendido que va a las alus
);


endmodule