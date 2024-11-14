`default_nettype none
`define DUMPSTR "SE_TB.vcd"
`timescale 100 ns / 10 ns 

module SE_TB;
    parameter DURATION =  10; 

    reg [24:0] inm_test;    //entrada
    reg         src_test;    //tipo de operacion
    wire [31:0] inmExt_test;    //salida
    
    SE SE_UUT(
        .inm(inm_test),  
        .src(src_test),
        .inmExt(inmExt_test)
    );
  
    initial begin       
        $dumpfile(`DUMPSTR); 
        $dumpvars(0, SE_TB); 

        inm_test = 25'b1001110011110000000000000;//inm de prueba (tipo I)        
        src_test = 1'b0;

        #5
        inm_test = 25'b1101010000000000000010101;//inm de prueba (tipo S)
        src_test = 1'b1;
        

        #(DURATION)
        $finish;

    end

endmodule

