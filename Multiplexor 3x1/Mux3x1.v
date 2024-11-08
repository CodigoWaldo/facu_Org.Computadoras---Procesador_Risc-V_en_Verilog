module mu(
    input wire  [31:0]  i1,
    input wire  [31:0]  i2,
    input wire  [31:0]  i3,
    input wire  [1:0]  sel,
    output wire [31:0] out
);
reg [31:0] aux;

always@(posedge clk)
    begin
        case(sel)
            1'b00:
                aux = i1;
            1'b01:
                aux = i2;
            1'b10:
                aux = i3;                
        endcase
    end
assign out = aux;

endmodule