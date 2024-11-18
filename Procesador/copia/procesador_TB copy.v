/*
`default_nettype none
`define DUMPSTR "procesador_TB.vcd"
`timescale 100 ns / 10 ns

module procesador_TB;
    parameter DURATION = 10;

    reg clk_test = 0;
    always #1 clk_test = ~clk_test;

    procesador procesador_UUT (
       clk_test
    );


    initial begin
        $dumpfile(`DUMPSTR);
        $dumpvars(0, procesador_TB);

        #0
        
        #(DURATION)
        $finish;
    end



endmodule
*/