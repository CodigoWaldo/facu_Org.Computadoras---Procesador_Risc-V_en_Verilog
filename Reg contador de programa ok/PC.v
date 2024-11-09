/*
Contador de programa: es un registro de 32 bits que guarda la dirección de la 
instrucción que se está ejecutando.
*/

module PC(    
    input wire          clk     ,
    input wire [31:0]   pcNext  ,
    output reg [31:0]   pc       
);

always @(posedge clk) begin 
    pc <= pcNext;
end

endmodule
