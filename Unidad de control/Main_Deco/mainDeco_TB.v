`default_nettype none
`define DUMPSTR "mainDeco_TB.vcd"
`timescale 100 ns / 10 ns

module main_deco_TB;
    parameter DURATION =  10; 
    
    reg [6:0]    op_test;

    wire          branch_test;
    wire          jump_test; 
    wire [1:0]    resSrc_test;    
    wire          memWrite_test;    
    wire          aluSrc_test;    
    wire [1:0]    immSrc_test;
    wire          regWrite_test;
    wire [1:0]    aluOp_test;

    main_deco main_deco_UUT(
        .op(op_test),
        .branch(branch_test),     // branch signal
        .jump(jump_test),       // jump signal
        .resSrc(resSrc_test),    // result source
        .memWrite(memWrite_test),   // memory write signal
        .aluSrc(aluSrc_test),     // ALU source signal
        .immSrc(immSrc_test),    // immediate source
        .regWrite(regWrite_test),   // register write signal
        .aluOp(aluOp_test) 
    );
  
    initial begin      
        $dumpfile(`DUMPSTR);  
        $dumpvars(0, main_deco_TB);   
        op_test = 7'd3;
        #1
        op_test = 7'd35;
        #1
        op_test = 7'd99;
        #(DURATION)
        $finish;
    end
endmodule

