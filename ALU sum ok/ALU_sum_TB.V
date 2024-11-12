`default_nettype none
`define DUMPSTR "ALU_SUM_TB.vcd"
`timescale 100 ns / 10 ns

module  ALU_sum_TB;
    parameter DURATION =  10;    
    
    reg [31:0]    srcA_test;    
    reg [31:0]    srcB_test;
    reg [31:0]    res_test;
   

    ALU_sum ALU_SUM_UUT(       
        .srcA(srcA_test),
        .srcB(srcB_test)      
    );
  
    initial begin      
        
        srcA_test = 32'h00000000;
        srcB_test = 32'h00000000; 

        $dumpfile(`DUMPSTR);  
        $dumpvars(0, ALU_sum_TB);   

        #1
        srcA_test = 32'h00000001;       
        #3.5
        srcB_test = 32'h00000010;         
       

        #(DURATION)
        $finish;
    end
endmodule

