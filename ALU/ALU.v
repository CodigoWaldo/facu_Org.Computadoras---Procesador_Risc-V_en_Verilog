module DM(
    input wire [31:0]   srcA,
    input wire [31:0]   srcB,
    input wire [2:0]   ALUControl, //op what gotta do
    output wire zero,   //devuelve siempre zero (bandera creo)
    output reg [31:0]   res   // Read data output 1   
);

reg [31:0] res0;

always @(posedge clk) 
    begin
  
        case (ALUControl)
        3'b000: //add
            res0 = srcA + srcB;
        3'b001: //subtract
            res0 = srcA - srcB;
        3'b010: //and
            res0 = srcA and srcB;
        3'b011: //or
            res0 = srcA or srcB;
        3'b101: //set less than
        res0 = (srcA >srcB ? srcA : srcB);
        default: // do nothing
        res0=srcA;        
    
    
        res <= res0;  //result value assing
    end

endmodule