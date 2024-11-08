module BR(
    input wire          clk , // Clock
    input wire          we  , // Write enable    
    input wire [4:0]    a1  , // Address input 1
    input wire [4:0]    a2  , // Address input 2 
    input wire [4:0]    a3  , // Address input 3 - EL QUE SE VA ESCRIBIR
    output reg [31:0]   wd3 , // Write data input

    output reg [31:0]   rd1 , // Read data output 1
    output reg [31:0]   rd2       
);

reg [31:0] BankReg [31:0];       // 32x32-bit register file

always @(posedge clk) begin
    if (we) begin           // Write operation executed when we enabled
        //BankReg[a1] <= wd3;      // Write data to address a1       
        //BankReg[a2] <= wd3;      // Write data to address a2
        BankReg[a3] <= wd3;      // Write data to address a3
    end
    rd1 <= BankReg[a1];          // Read data from address a1
    rd2 <= BankReg[a2];          // Read data from address a2
end

endmodule