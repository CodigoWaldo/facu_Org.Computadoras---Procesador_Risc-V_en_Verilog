/*
Banco de registro: contiene todos los registros y tiene dos 
puertos de lectura y uno de escritura. El banco genera el contenido de los registros 
correspondientes a la entradas de lectura (A1, A2) en las salidas (RD1, RD2). Una 
escritura debe indicarse explícitamente mediante la señal de control de escritura
*/

module BR(
    input wire          clk ,           // Reloj
    input wire         regWrite  ,      // Habilitación de escritura (we)   
    input wire [4:0]    a1  ,           // Dirección de lectura 1
    input wire [4:0]    a2  ,           // Dirección de lectura 2
    input wire [4:0]    a3  ,           // Dirección de entrada 3 - EL QUE SE VA A ESCRIBIR
    input wire [31:0]   wd3 ,           // Entrada de datos para escribir

    output wire [31:0]   rd1 ,          // Salida de datos de lectura 1
    output wire [31:0]   rd2            // Salida de datos de lectura 2 
   
);

reg [31:0] BankReg [31:0];            // Archivo de registros de 32 registros de 32 bits cada uno


always @(posedge clk) begin         // ESCRITURA SINCRONICA
    
    if (regWrite) begin                    
        BankReg[a3] <= wd3;          
    end
    BankReg[0] <= 0;
  
end 
                                    //LECTURA ASINCRONICA
assign rd1 = BankReg[a1];           // Leer datos desde la dirección a1
assign rd2 = BankReg[a2];           // Leer datos desde la dirección a2


endmodule
