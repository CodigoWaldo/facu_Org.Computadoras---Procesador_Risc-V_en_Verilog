/*
Memoria de datos: es la región de la memoria del sistema donde se alojan los datos 
utilizados por el programa (datos dinamicos y estaticos, pila).
*/

module DM(
        input wire              clk,            
        input wire [4:0]        addressDM,      // Dirección de memoria accedida.   
        input wire [31:0]       wd,             // Entrada de escritura de datos.
        input wire              we,             // Write enable.
        output wire [31:0]      rd              // Salida del dato leido.
);

reg [31:0] MEM [31:0];              // 32x32-bit memoria de datos.

always @(posedge clk) begin         // Escritura sincrónica.
    if(we) begin                    
        MEM[addressDM] <= wd;       // Escribir datos en dirección adressdm.
    end        
end

assign rd =  MEM[addressDM];        //Lectura asíncrona.

endmodule