module mu(
    input wire  [31:0]  i1,
    input wire  [31:0]  i2,
    input wire    sel,
    output wire [31:0] out
);
reg [31:0] aux;

always@(posedge clk)
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