module PC(
    //declaracion de modulos con sus entradas y salidas
    input wire          clk     ,
    input wire [31:0]   pcNext  ,
    output reg [31:0]   pc       
);
//declaracion de señales y variables que se usan 
//internamente

//....

//descripción del modulo
    always @(posedge clk) begin //siempre que clck =1 se ejecuta
        pc <= pcNext;
    end

endmodule
