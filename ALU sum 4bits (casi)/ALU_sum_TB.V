`default_nettype none
`define DUMPSTR "ALU_SUM_4b_TB.vcd"
`timescale 100 ns / 10 ns

module  ALU_sum_4b_TB;
    parameter DURATION =  10;    
    
    reg [31:0]    src_test;        
    reg [31:0]    res_test;
   

    ALU_sum_4b ALU_SUM_UUT(       
        .src(src_test),               
    );
  
    initial begin      
        
        src_test = 32'h00000000;
        

        $dumpfile(`DUMPSTR);  
        $dumpvars(0, BR_TB);   

        #1
        src_test = 32'h00000001;       
        #3.5
        src_test = 32'h00000010;         
       

        #(DURATION)
        $finish;
    end
endmodule

