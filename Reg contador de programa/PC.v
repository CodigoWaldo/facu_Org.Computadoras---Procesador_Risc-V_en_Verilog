/*
Contador de programa: es un registro de 32 bits que guarda la dirección de la 
instrucción que se está ejecutando.
*/


module PC(    
    input wire          clk,        // Reloj
    input wire          reset,      // Señal de reset
    input wire [31:0]   pcNext,     // Dirección siguiente del PC
    output reg [31:0]   pc          // Valor actual del PC
);

always @(posedge clk or posedge reset) begin 
    if (reset) begin
        pc <= 32'b0;  // Cuando se activa el reset, se reinicia el PC a 0
    end else begin
        pc <= pcNext; // Cuando no hay reset, el PC sigue el valor de pcNext
    end
end

endmodule