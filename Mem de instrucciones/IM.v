`timescale 1ns/1ps

// Module Declaration
module mem_instr(
    input [4:0]      address,  //5 bits input address (max 32)
    output reg [31:0] rd        // 32-bit output data
);

reg [31:0] IM [31:0];           // 32 instrucciones de 32 bits
assign IM[0] = 32'h01234567;    //registro 0 hardcodeado
assign IM[0] = 32'h01234568;    //registro 1 hardcodeado
assign IM[0] = 32'h01234569;    //registro 2 hardcodeado

always @(*) begin
    begin
            rd = IM[address[5:0]]; //devuelve el registro de IM en la pos adress recibida
    end
   


endmodule