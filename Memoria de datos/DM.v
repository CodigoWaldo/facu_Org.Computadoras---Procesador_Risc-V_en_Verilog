/*
Memoria de datos: es la región de la memoria del sistema donde se alojan los datos 
utilizados por el programa (datos dinamicos y estaticos, pila).
*/

module DM(
    input wire          clk,            
    input wire [4:0]    addressDM,   // dirección de memoria accedida     
    input wire [31:0]   wd,           // entrada de escritura de datos
    input wire          we,          // Write enable

    output wire [31:0]   rd          // salida de dato leido
);

reg [31:0] MEM [31:0];              // 32x32-bit memoria de datos

reg [31:0] rdaux;
always @(posedge clk) begin
    
    if(we) begin                    
        MEM[addressDM] <= wd;       // escribir datos en dirección adressdm       
    end
       
    rdaux <=  MEM[addressDM];
end
assign rd = rdaux;



endmodule