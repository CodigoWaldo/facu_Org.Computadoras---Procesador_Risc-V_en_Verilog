`default_nettype none
`define DUMPSTR "MP_3x1_TB.vcd"
`timescale 100 ns / 10 ns

module  MP_3x1_TB;
    parameter DURATION =  10;    
    
    reg [31:0]    srcA_test;        
    reg [31:0]    srcB_test;     
    reg [31:0]    srcC_test;    
    reg [1:0]     sel_test; 
    wire [31:0]     out_test; 


    MP_3x1 MP_3x1_UUT(       
        .i1(srcA_test),
        .i2(srcB_test),
        .i3(srcC_test),
        .out(out_test),
        .sel(sel_test)               
    );

    initial begin          
        $dumpfile(`DUMPSTR);  
        $dumpvars(0, MP_3x1_TB);   

        srcA_test = 32'h01001001;
        srcB_test = 32'h00000000;
        srcC_test = 32'h11111111;
        sel_test = 2'b00;
        
        #2.5
        sel_test = 2'b01;    
        #5
        sel_test =  2'b10;     
       

        #(DURATION)
        $finish;
    end
endmodule

