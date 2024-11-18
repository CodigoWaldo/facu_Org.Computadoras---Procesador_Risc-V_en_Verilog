/*`default_nettype none
`define DUMPSTR "BR_TB.vcd"
`timescale 100 ns / 10 ns

module BR_TB;
    parameter DURATION =  10; 
    reg clk_test = 0;
    always #1 clk_test = ~clk_test;
    
    reg          we_test;    
    reg [4:0]    a1_test;
    reg [4:0]    a2_test; 
    reg [4:0]    a3_test;
    reg [31:0]  wd3_test;

    wire [31:0] rd1_test;
    wire [31:0] rd2_test;

    //BankReg[X] 

    BR BR_UUT(
        .clk(clk_test),
        .we(we_test),
        .a1(a1_test),
        .a2(a2_test),
        .a3(a3_test),
        .wd3(wd3_test)
    );
  
  
    initial begin     
        $dumpfile(`DUMPSTR);  
        $dumpvars(0, BR_TB);  

         
        BR_UUT.BankReg[0] = 32'h01230000;
        BR_UUT.BankReg[1] = 32'h01231111;
        BR_UUT.BankReg[2] = 32'h01232222;
        BR_UUT.BankReg[3] = 32'h01233333;
        we_test = 1'b0;
        wd3_test = 32'b0; 

        #1
        a1_test = 5'b00011;
        a2_test = 5'b00010;
        a3_test = 5'b00011;
        #3.5
        we_test = 1'b1;
        #1
        
        

        #(DURATION)        
        $finish;
    end





endmodule

