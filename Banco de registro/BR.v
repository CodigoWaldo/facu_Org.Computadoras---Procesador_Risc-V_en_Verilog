/*
Banco de registro: contiene todos los registros y tiene dos 
puertos de lectura y uno de escritura. El banco genera el contenido de los registros 
correspondientes a la entradas de lectura (A1, A2) en las salidas (RD1, RD2). Una 
escritura debe indicarse explícitamente mediante la señal de control de escritura
*/

module BR(
    input wire          clk ,           // Reloj
    input wire         regWrite  ,      // Habilitación de escritura (we)   
    input wire [4:0]    a1  ,           // Dirección de entrada 1
    input wire [4:0]    a2  ,           // Dirección de entrada 2
    input wire [4:0]    a3  ,           // Dirección de entrada 3 - EL QUE SE VA A ESCRIBIR
    input wire [31:0]   wd3 ,           // Entrada de datos para escribir

    output wire [31:0]   rd1 ,          // Salida de datos de lectura 1
    output wire [31:0]   rd2       
   
);

reg [31:0] BankReg [31:0];              // Archivo de registros de 32 registros de 32 bits cada uno
initial begin    
    BankReg[0] = 32'h00000000;        // Dirección 0 (zero)
    BankReg[1] = 32'h00000000;        // Dirección 1 (ra - Return Address)
    BankReg[2] = 32'h00000000;        // Dirección 2 (sp - Stack Pointer)
    BankReg[3] = 32'h00000000;        // Dirección 3 (gp - Global Pointer)
    BankReg[4] = 32'h00000000;        // Dirección 4 (tp - Thread Pointer)
    BankReg[5] = 32'h00000000;        // Dirección 5 (t0 - Temporal 0)
    BankReg[6] = 32'h00000000;        // Dirección 6 (t1 - Temporal 1)
    BankReg[7] = 32'h00000000;        // Dirección 7 (t2 - Temporal 2)
    BankReg[8] = 32'h00000000;        // Dirección 8 (s0 - Saved Register 0, fp - Frame Pointer)
    BankReg[9] = 32'h00000000;        // Dirección 9 (s1 - Saved Register 1)
    BankReg[10] = 32'h00000000;       // Dirección 10 (a0 - Argument 0)
    BankReg[11] = 32'h00000000;       // Dirección 11 (a1 - Argument 1)
    BankReg[12] = 32'h00000000;       // Dirección 12 (a2 - Argument 2)
    BankReg[13] = 32'h00000000;       // Dirección 13 (a3 - Argument 3)
    BankReg[14] = 32'h00000000;       // Dirección 14 (a4 - Argument 4)
    BankReg[15] = 32'h00000000;       // Dirección 15 (a5 - Argument 5)
    BankReg[16] = 32'h00000000;       // Dirección 16 (a6 - Argument 6)
    BankReg[17] = 32'h00000000;       // Dirección 17 (a7 - Argument 7)
    BankReg[18] = 32'h00000000;       // Dirección 18 (s2 - Saved Register 2)
    BankReg[19] = 32'h00000000;       // Dirección 19 (s3 - Saved Register 3)
    BankReg[20] = 32'h00000000;       // Dirección 20 (s4 - Saved Register 4)
    BankReg[21] = 32'h00000000;       // Dirección 21 (s5 - Saved Register 5)
    BankReg[22] = 32'h00000000;       // Dirección 22 (s6 - Saved Register 6)
    BankReg[23] = 32'h00000000;       // Dirección 23 (s7 - Saved Register 7)
    BankReg[24] = 32'h00000000;       // Dirección 24 (s8 - Saved Register 8)
    BankReg[25] = 32'h00000000;       // Dirección 25 (s9 - Saved Register 9)
    BankReg[26] = 32'h00000000;       // Dirección 26 (s10 - Saved Register 10)
    BankReg[27] = 32'h00000000;       // Dirección 27 (s11 - Saved Register 11)
    BankReg[28] = 32'h00000000;       // Dirección 28 (t3 - Temporal 3)
    BankReg[29] = 32'h00000000;       // Dirección 29 (t4 - Temporal 4)
    BankReg[30] = 32'h00000000;       // Dirección 30 (t5 - Temporal 5)
    BankReg[31] = 32'h00000000;       // Dirección 31 (t6 - Temporal 6)
end



always @(posedge clk) begin         // ESCRITURA SINCRONICA
    
    if (regWrite && a3 != 0) begin                    
        BankReg[a3] <= wd3;          
    end
  
end
                                    //LECTURA ASINCRONICA

assign rd1 = BankReg[a1];        // Leer datos desde la dirección a1
assign rd2 = BankReg[a2];        // Leer datos desde la dirección a2


endmodule
