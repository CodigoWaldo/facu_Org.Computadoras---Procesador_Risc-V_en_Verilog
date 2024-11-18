`default_nettype none
`define DUMPSTR "datapath_TB.vcd"
`timescale 100 ns / 10 ns

module datapath;
    parameter DURATION = 10;

    reg        pcSrc_test;       // Señal hacia el multiplexor 2x1
    reg        clk_test;
    reg [1:0]  resultSrc_test;  // Fuente del resultado
    reg        memWrite_test;    // Señal de escritura en memoria
    reg        aluSrc_test;      // Señal de fuente para la ALU
    reg [1:0]  immSrc_test;     // Fuente del inmediato
    reg        regWrite_test;   // Señal de escritura en el registro
    reg [2:0] aluControl_test; 

    wire [6:0]   op_test;
    wire [2:0]   f3_test;
    wire [6:0]   f7_test;
    wire         zero_test;



    datapath datapath_UUT (
        clk_test, pcSrc_test, resultSrc_test, memWrite_test, aluSrc_test, immSrc_test, regWrite_test, aluControl_test,
        f7_test, f3_test, op_test, zero_test
    );

    initial begin
        $dumpfile(`DUMPSTR);
        $dumpvars(0, datapath_TB);

        // Pruebas iniciales
        #0
        #1
        #(DURATION)
        $finish;
    end
endmodule
