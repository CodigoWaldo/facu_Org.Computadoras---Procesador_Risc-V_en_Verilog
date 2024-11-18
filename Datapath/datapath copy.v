/*
Camino de datos: Conexiones que relacionan los distintos 
modulos para conformar el procesador.


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
//--------------------- MEMORIAS
DM DM_inst( //memoria de datos
    .clk                 (clk),
    .address             (pAddr),        // desde la MMU
    .wd                  (rd),           // desde el banco de registros
    .we                  (dataEn),       // desde la MMU
    .rd                  (RDM)           // hacia el multiplexor
);
mem_instr mem_instr_inst(                //memoria de instrucciones
    .address             (pAddr),        // desde la MMU
    .rd                  (RDS)           // hacia el multiplexor
);
BR BR_inst(
                                        //banco de registros 
    .virtual_addr        (AluRes),       // desde la ALU
    .physical_addr       (pAddr),        // hacia las memorias       
    .block_select        (mmuSel),       // hacia el multiplexor
    .we                  (WE),           // desde la unidad de control
    .de                  (dataEn),       // hacia la memoria de datos
    .se                  (stackEn)       // hacia la memoria de pila
    .UARTEnable          (uartEn)        // hacia el UART


    input wire          clk , // Clock
    input wire          we  , // Write enable    
    input wire [4:0]    a1  , // Address input 1
    input wire [4:0]    a2  , // Address input 2 
    input wire [4:0]    a3  , // Address input 3 - EL QUE SE VA ESCRIBIR
    input wire [31:0]   wd3 , // Write data input

    input reg [31:0]   rd1 , // Read data input 1
    input reg [31:0]   rd2  

);

//--------------------- SUMADORES
ALU_sum ALU_sum_inst
//---------------------  MULTIPLEXORES
MP_2x1 mp_2x1_inst0(1,2,pcSrc);
MP_2x1 mp_3x1_inst1();


//--------------------- PC (contador de programa)
pc_module pc_module_inst(
    clk                  (clk     ),     // entrada
    pc                   (pc)            // hacia la memoria de instrucciones y sumadores
    pcNext               (pck1  ),       // entrada
);

//--------------------- MEMORIA DE INSTRUCCIONES
mem_instr mem_instr_inst( 
    address              (pc),           // desde el contador de programa
    rd                   (mInstr)        // hacia la unidad de control, banco de registros y extensión   
);


//--------------------- BANCO DE REGISTROS
reg_bank reg_bank_inst(
    .clk                 (clk ),            
    .a1                  (mInstr[19:15]),// desde la instrucción en memoria    
    .a2                  (mInstr[24:20]),// desde la instrucción en memoria      
    .a3                  (mInstr[11:7]), // desde la instrucción en memoria      
    .wd3                 (wd3),          // desde el multiplexor  
    .we                  (RegW),         // desde la unidad de control             
    .rd1                 (srcA),         // hacia la ALU
    .rd2                 (rd2)           // hacia el multiplexor y memorias
);

//--------------------- ALU
alu alu_inst(
    srcA                 ( srcA ),       // desde el archivo de registros   
    srcB                 ( srcB ),       // desde el multiplexor   
    ALUControl           ( AControl ),   // desde la unidad de control
    zero                 ( zero     ),   // hacia la unidad de control   
    res                  ( AluRes  )     // hacia la MMU y el multiplexor de resultados
);

//--------------------- EXTENSIÓN DE SIGNO
sign_ext sign_ext_inst(
    .inm                 (mInstr[31:7]), //desde la instrucción en memoria
    .src                 (imm_Src),      //desde la unidad de control
    .inmExt              (inmExt)        //hacia el multiplexor, sumadores y PCjump
);


endmodule
*/