/*
Banco de registro: contiene todos los registros y tiene dos 
puertos de lectura y uno de escritura. El banco genera el contenido de los registros 
correspondientes a la entradas de lectura (A1, A2) en las salidas (RD1, RD2). Una 
escritura debe indicarse explícitamente mediante la señal de control de escritura
*/

module BR(
    input wire          clk , // Reloj
    input wire          we  , // Habilitación de escritura    
    input wire [4:0]    a1  , // Dirección de entrada 1
    input wire [4:0]    a2  , // Dirección de entrada 2
    input wire [4:0]    a3  , // Dirección de entrada 3 - EL QUE SE VA A ESCRIBIR
    input wire [31:0]   wd3 , // Entrada de datos para escribir

    output reg [31:0]   rd1 , // Salida de datos de lectura 1
    output reg [31:0]   rd2       
);

reg [31:0] BankReg [31:0];       // Archivo de registros de 32 registros de 32 bits cada uno

always @(posedge clk) begin
    if (we) begin                    // Operación de escritura ejecutada cuando habilitación de escritura está activada
        BankReg[a3] <= wd3;          // Escribir datos en la dirección a3
    end
       rd1 <= BankReg[a1];          // Leer datos desde la dirección a1
       rd2 <= BankReg[a2];          // Leer datos desde la dirección a2
end

endmodule
