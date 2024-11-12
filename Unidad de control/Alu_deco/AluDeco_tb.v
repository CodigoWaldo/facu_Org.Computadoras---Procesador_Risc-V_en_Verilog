`default_nettype none
`define DUMPSTR "AluDeco_TB.vcd"
`timescale 100 ns / 10 ns

module alu_deco_TB;
    parameter DURATION =  10; 
    
    reg [6:0]    op_test;
    reg [6:0]    f7_test;
    reg [2:0]    f3_test; 
    reg          aluOp_test;    

    wire [2:0] aluControl_test;

    alu_deco alu_deco_UUT(
        .op(op_test),
        .f7(f7_test),
        .f3(f3_test),
        .aluOp(aluOp_test),
        .aluControl(aluControl_test)
    );
  
    initial begin      
        $dumpfile(`DUMPSTR);  
        $dumpvars(0, alu_deco_TB);   
        op_test = 2'b0;
        aluOp_test = 2'b0;
        f7_test = 7'b010000;
        f3_test= 3'b0;
        #1
        aluOp_test = 2'b01;
        #1.5
        aluOp_test = 2'b10;

        #(DURATION)
        $finish;
    end
endmodule

