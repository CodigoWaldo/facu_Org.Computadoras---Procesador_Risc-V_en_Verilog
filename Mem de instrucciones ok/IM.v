/*
 Memoria de programa: Es la región de la memoria del sistema donde se 
aloja el programa que se está ejecutando.
*/

module mem_instr(
    input [4:0]      address,   
    output reg [31:0] rd        
);

reg [31:0] IM [31:0];           // 32 instrucciones de 32 bits
  //  IM[0] = 32'h01234567;       // instrucción en la posición 0
  //  IM[1] = 32'h01233333;       // instrucción en la posición 1
  //  IM[2] = 32'h01234569;       // instrucción en la posición 2

always @(*) 
    begin
            rd = IM[address]; //devuelve el registro de IM en la pos adress recibida
    end
   
endmodule

