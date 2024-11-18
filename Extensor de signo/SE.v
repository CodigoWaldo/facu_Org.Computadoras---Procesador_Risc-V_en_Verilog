/*
Unidad de generador de datos (Sign extended): es un circuito combinacional que genera el campo 
de dato inmediato, de 12 ó 20 bits, para las instrucciones aritméticas, lógicas, carga, 
almacenamiento, y saltos. Reorganiza la información del campo inmediato, de 
acuerdo con el código de operación, para ser utilizada por el procesador para 
ejecutar la instrucción correspondiente. 
Estas tareas involucran reordenar los bits, completar con 0 y desplazar el dato 
resultante de acuerdo al tipo de operación.
*/

module SE(
    input wire [24:0]   inm,        // Dato a extender 
    input wire [1:0]   src,        // Tipo de instrucción a ejecutar 
    output reg [31:0]  inmExt     // Dato extendido
);

    always @(*) begin
        case (src)
            2'b00: // Tipo I
                inmExt = {20'b0, inm[24:13]};
            2'b01: // Tipo S
                inmExt = {20'b0, inm[24:18], inm[4:0]};

            2'b10: // Tipo B
                inmExt = {{19{inm[25]}}, inm[25], inm[7],
                 inm[30:25], inm[11:8], 1'b0};
            // Tipo R no lleva inm

            default:
                inmExt = 32'b0; //por si las moscas 
        endcase
    end
endmodule