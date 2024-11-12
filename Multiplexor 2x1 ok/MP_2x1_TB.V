`default_nettype none
`define DUMPSTR "MP_2x1_TB.vcd"
`timescale 100 ns / 10 ns

module  MP_2x1_TB;
    parameter DURATION =  10;    
    
    reg [31:0]    srcA_test;        
    reg [31:0]    srcB_test;     
    reg           sel_test; 

    MP_2x1 mu_2x1_UUT(       
        .i1(srcA_test),
        .i2(srcB_test),
        .sel(sel_test)               
    );
  
    initial begin      
        
        srcA_test = 32'h01001001;
        srcB_test = 32'h00000000;
        sel_test = 1'b0;

        $dumpfile(`DUMPSTR);  
        $dumpvars(0, MP_2x1_TB);   

        #1
        sel_test = 1'b1;       
        #3.5
        sel_test = 1'b0;         
       

        #(DURATION)
        $finish;
    end
endmodule

