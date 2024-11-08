module SE(
    input wire [24:0]   inm,        // Dato a extender 
    input wire  [1:0]   src,        // Tipo de instrucción a ejecutar 
    output wire [25:0]  inmExt,     // Dato extendido
);
 
//

    always @(*) begin
        case (src)//segun el tipo de operacion, concateno el inm con la repeticion del bit de sign [25]
                    //la cantidad de bits a rellenar para llegar a los 32
            3'b000: // Tipo I
                inmExt = {{20{inm[25]}}, inm[25:20]};
            3'b001: // Tipo S
                inmExt = {{20{inm[25]}}, inm[25:25], inm[11:7]};
            3'b010: // Tipo B
                inmExt = {{19{inm[25]}}, inm[25], inm[7],
                 inm[30:25], inm[11:8], 1'b0};
            3'b011: // Tipo J
                inmExt = {{11{inm[25]}}, inm[25], inm[19:12], 
                inm[20], inm[30:21], 1'b0};
            //3'b011: // Tipo U (Desactivado para usar un bus de 4 bits)
            //inmExt = {inm[25:12], 12'b0};
            default:
                inmExt = 32'b0; // por si las chauchas
        endcase
    end
endmodule