/*
Multiplexor: Modulo que permite la entrada de multiples
señales y elegir una de ellas para establecer una salida única.
*/
module MP_2x1(
    input wire  [31:0]  i1,
    input wire  [31:0]  i2,
    input     sel,
    output wire [31:0] out
);
reg [31:0] aux;

always@(*)
    begin
        case(sel)
            1'b0:
                aux = i1;
            1'b1:
                aux = i2;
        endcase
    end
assign out = aux;

endmodule