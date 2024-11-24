module alu_deco(
    input [6:0] op,
    input [6:0] f7,
    input [2:0] f3,
    input [1:0] aluOp,              // Cambiado a wire (implícito)
    output [2:0] aluControl
);

reg [2:0] aluControlAux;

always @(*) begin
    case (aluOp)
        2'b00:                                  // lw, sw
            aluControlAux = 3'b000;             // add
        2'b01:                                  // beq
            aluControlAux = 3'b001;             // subtract
        2'b10:
            case (f3)
                3'b000:
                    if (f7[5] && op[5]) begin   // if aritmética
                        aluControlAux = 3'b001; // subtract
                    end else begin
                        aluControlAux = 3'b000; // add
                    end
                3'b010:
                    aluControlAux = 3'b101;     // set less than
                3'b110:
                    aluControlAux = 3'b011;     // or
                3'b111:
                    aluControlAux = 3'b010;     // and
                default: aluControlAux = 3'b000;
            endcase
        default: aluControlAux = 3'b000;
    endcase
end

assign aluControl = aluControlAux;

endmodule
