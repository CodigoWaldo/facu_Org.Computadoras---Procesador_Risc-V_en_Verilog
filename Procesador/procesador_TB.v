`default_nettype none
`define DUMPSTR "procesador_TB.vcd"
`timescale 100 ns / 10 ns

module procesador_TB;
    parameter DURATION = 10;
    

    procesador procesador_UUT (
        
    );

    initial begin
        $dumpfile(`DUMPSTR);
        $dumpvars(0, UC_TB);

        

        #(DURATION)
        $finish;
    end
endmodule
