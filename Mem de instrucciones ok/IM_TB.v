`default_nettype none
`define DUMPSTR "IM_TB.vcd"
`timescale 100 ns / 10 ns

module IM_TB;
    parameter DURATION =  10; 
    reg [4:0] address_test;
    output wire [31:0] rd_test;

    mem_instr IM_UUT(
        .address(address_test),
        .rd(rd_test)
    );
  
    initial begin      
        IM_UUT.IM[0] = 32'h01234567;
        IM_UUT.IM[1] = 32'h01234333;
        IM_UUT.IM[2] = 32'h01234569;
      
        $dumpfile(`DUMPSTR);  //$dumpfile= palabra clave, donde vamos a guardar la salida de la prueba
        $dumpvars(0, IM_TB); //nombre del modulo a testear (este mismo IM_TB)
        //#1 tiempo de espera para la siguiente ejecución (1 unidad de tiempo)
        #2
        address_test =  00000;
        #3.5
        address_test = 00001;

        #(DURATION)
        $finish;

    end

endmodule

