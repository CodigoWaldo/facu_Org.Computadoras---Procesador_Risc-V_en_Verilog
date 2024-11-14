/*
Multiplexor: Modulo que permite la entrada de multiples
señales y elegir una de ellas para establecer una salida única.
*/

module MP_3x1(
    input wire  [31:0]  i1,
    input wire  [31:0]  i2,
    input wire  [31:0]  i3,
    input wire  [1:0]  sel,
    output wire [31:0] out
);
reg [31:0] aux;

always@(*)
    begin
        case(sel)
            2'b00:
                aux = i1;
            2'b01:
                aux = i2;
            2'b10:
                aux = i3;                
        endcase
    end
assign out = aux;

endmodule