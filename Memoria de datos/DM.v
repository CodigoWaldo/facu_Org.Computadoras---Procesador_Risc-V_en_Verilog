module DM(
    input wire          clk ,       // Clock
    input wire [4:0]    adressDM  , //     
    output reg [31:0]   wd ,        // Write data input
    input wire          we  ,       // Write enable

    output reg [31:0]   rd   // Read data output 1   
);

reg [31:0] MEM [31:0];       // 32x32-bit data memory

always @(posedge clk) begin
    if (we) begin           // Write operation executed when we enabled
        MEM[adressDM] <= wd;      // Write data to address a3
        rd <= wd;
    end
    rd <= wd;          // Read data from address a1
   
end

endmodule