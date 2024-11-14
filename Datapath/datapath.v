/*
Camino de datos: Conexiones que relacionan los distintos 
modulos para conformar el procesador.
*/

//Unidad de control
`include "../Unidad de control/UC.v"
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

module datapath(
        input logic rst_n,  //reset
        input logic clk     //relog
    );

//--------------------- UNIDAD DE CONTROL
UC UC_inst( //🦎
    .op                  (mInstr[6:0]  ),// desde la instrucción en memoria
    .f3                  (mInstr[14:12]),// desde la instrucción en memoria
    .f7                  (mInstr[30]   ),// desde la instrucción en memoria
    .zero                (zero         ),// desde la ALU
    .branch              (branchSel    ),// hacia el multiplexor
    .jump                (jumpSel      ),// hacia el multiplexor
    .regWrite            (RegW         ),// hacia el banco de registros
    .memWrite            (WE           ),// hacia la MMU
    .aluSrc              (aluSrc       ),// hacia el multiplexor
    .aluControl          (AControl     ),// hacia la ALU
    .resSrc              (resSrc       ),// hacia el multiplexor
    .immSrc              (imm_Src      )// hacia la extensión    
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

    output reg [31:0]   rd1 , // Read data output 1
    output reg [31:0]   rd2  


);

//--------------------- SUMADORES
adder16 adder_A(
    .op1                 (addSrc),       // desde el multiplexor
    .op2                 (pc),           // desde el PC
    .res                 (pcNext)        // hacia el multiplexor
);
adder16 adder_B(
    .op1                 (inmExt),       // desde la extensión
    .op2                 (pc),           // desde el PC
    .res                 (pcjump)        // hacia el multiplexor
);      

//---------------------  MULTIPLEXORES
mu16 mu_instA(  
    .i1                  (4),            // 4 bits
    .i2                  (inmExt),       // desde la extensión  
    .sel                 (branchSel),    // desde la unidad de control
    .out                 (addSrc)        // hacia la extensión 
);
mu16 mu_instB(
    .i1                  (pcNext ),      // desde el sumador1
    .i2                  (pcJump ),      // desde el sumador2
    .sel                 (jumpSel),      // desde la unidad de control
    .out                 (pck1 )         // hacia el contador de programa
);
mu mu_instC( //32 bits
    .i1                  (rd2),          // desde el banco de registros
    .i2                  (inmExt),       // desde la extensión
    .sel                 (aluSrc),       // desde la unidad de control
    .out                 (srcB)          // hacia la ALU
);
// multiplexor de memoria
mu4 mu4_instA( 
    .i1                  (RDM),          // desde la memoria de datos
    .i2                  (RDS),          // desde la memoria de pila
    .i3                  (RDU),          // desde el UART
    .i4                  ( ),            // sin uso
    .sel                 (mmuSel),       // desde la MMU
    .out                 (ReadData)      // hacia el multiplexor
);
//multiplexor de resultado
mu4 mu4_instB(
    .i1                  (AluRes),       // desde la ALU
    .i2                  (ReadData),     // desde el multiplexor de memoria
    .i3                  (pcNext ),      // desde el PC
    .i4                  ( ),            // sin uso
    .sel                 (resSrc),       // desde la unidad de control
    .out                 (wd3)           // hacia el archivo de registros
);
mu16 mu16_inst(); 

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