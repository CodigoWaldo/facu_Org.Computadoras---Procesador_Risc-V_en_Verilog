`default_nettype none
`define DUMPSTR "ALU_TB.vcd"
`timescale 100 ns / 10 ns

module  ALU_TB;
    parameter DURATION =  10;    
    
    reg [31:0]    srcA_test;    
    reg [31:0]    srcB_test;
    reg [2:0]     aluControl_test;
    wire [31:0]    res_test;
   
    ALU ALU_UUT(       
        .srcA(srcA_test),
        .srcB(srcB_test),      
        .ALUControl(aluControl_test),
        .res(res_test)
    );
  
    initial begin      
        $dumpfile(`DUMPSTR);  
        $dumpvars(0, ALU_TB);   
        
        srcA_test = 32'h000000FF; //255 en decimal
        srcB_test = 32'h0000000F; //15 en decimal

        #0
        aluControl_test = 3'b000;
        #1
        aluControl_test = 3'b001;
        #2
        aluControl_test = 3'b010;      
        #3
        aluControl_test = 3'b011;
        #4
        aluControl_test = 3'b100;  
            
       

        #(DURATION)
        $finish;
    end
endmodule

