/*
 Memoria de programa: Es la región de la memoria del sistema donde se 
aloja el programa que se está ejecutando.
*/
module mem_instr(
    input [4:0]      address,   
    output reg [31:0] rd        
);

reg [31:0] memory [31:0];               // 32 instrucciones de 32 bits que almacena el programa de prueba "dumpMemory.hex".
                                            
initial begin                           // Inicialización de la memoria ROM   
    memory[0] = 32'h00300413; // Dirección 0 
    memory[1] = 32'h00100493; // Dirección 1
    memory[2] = 32'h01000913; // Dirección 2
    memory[3] = 32'h009462b3; // Dirección 3
    memory[4] = 32'h00947333; // Dirección 4
    memory[5] = 32'h009403b3; // Dirección 5
    memory[6] = 32'h40940e33; // Dirección 6
    memory[7] = 32'h40848eb3; // Dirección 7
    memory[8] = 32'h00942f33; // Dirección 8
    memory[9] = 32'h0084afb3; // Dirección 9
    memory[10] = 32'h01d4afb3; // Dirección 10
    memory[11] = 32'h00100293; // Dirección 11
    memory[12] = 32'h00000313; // Dirección 12
    memory[13] = 32'h01228863; // Dirección 13
    memory[14] = 32'h005282b3; // Dirección 14
    memory[15] = 32'h00130313; // Dirección 15
    memory[16] = 32'hff5ff06f; // Dirección 16
    memory[17] = 32'h000004b3; // Dirección 17
    memory[18] = 32'h00000293; // Dirección 18
    memory[19] = 32'h00a00313; // Dirección 19
    memory[20] = 32'h00628863; // Dirección 20
    memory[21] = 32'h008484b3; // Dirección 21
    memory[22] = 32'h00128293; // Dirección 22
    memory[23] = 32'hff5ff06f; // Dirección 23
    memory[24] = 32'h00802023; // Dirección 24
    memory[25] = 32'h00902223; // Dirección 25
    memory[26] = 32'h01202423; // Dirección 26
    memory[27] = 32'h00002283; // Dirección 27
    memory[28] = 32'h00402303; // Dirección 28
    memory[29] = 32'h00802383; // Dirección 29
end

always @(*)                         //LECTURA ASÍNCRONA
    begin
            rd = memory[address];   //devuelve el registro de IM en la pos address recibida.
    end
   
endmodule

