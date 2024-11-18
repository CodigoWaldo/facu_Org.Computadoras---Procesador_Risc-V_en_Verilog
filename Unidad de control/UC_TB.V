`default_nettype none
`define DUMPSTR "UC_TB.vcd"
`timescale 100 ns / 10 ns

module UC_TB;
    parameter DURATION = 10;

    reg [6:0]   op_test;
    reg [2:0]   f3_test;
    reg [6:0]   f7_test;
    reg         zero_test;

    wire        pcSrc_test;       // Señal hacia el multiplexor 2x1
    wire [1:0]  resultSrc_test;  // Fuente del resultado
    wire        memWrite_test;    // Señal de escritura en memoria
    wire        aluSrc_test;      // Señal de fuente para la ALU
    wire [1:0]  immSrc_test;     // Fuente del inmediato
    wire        regWrite_test;   // Señal de escritura en el registro
    wire [2:0] aluControl_test; 

    UC UC_UUT (
        op_test, f3_test, f7_test, zero_test,
        pcSrc_test, resultSrc_test, memWrite_test, aluSrc_test, immSrc_test, regWrite_test, aluControl_test
    );

    initial begin
        $dumpfile(`DUMPSTR);
        $dumpvars(0, UC_TB);

        // Pruebas iniciales
        #0
        f7_test=0;
        f3_test=0;
        zero_test = 1'b1;
        op_test= 7'd3;
        #1
        f7_test=0;
        f3_test=3'b111;
        zero_test = 1'b1;
        op_test= 7'd51;
        #1
        f7_test=7'b0110000;
        f3_test=3'b000;
        zero_test = 1'b1;
        op_test= 7'd51;

        #(DURATION)
        $finish;
    end
endmodule
