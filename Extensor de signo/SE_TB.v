`default_nettype none
`define DUMPSTR(X) "SE_TB.vcd"
`timescale 100 ns / 10 ns //valor de unidad de tiempo / unidad de precision

module SE_TB;
    parameter DURATION =  10; //duracion total del test (10 seg)

    //se define el clock y cada cuanto cambia su valor (cada 50 ns)
    reg clk_test = 0;
    always #1 clk_test = ~clk_test; //alterna a su opuesto, de 0 a 1 y viceversa 

    //señales que enviará el test
    // wire test_a; //entrada del clk ya definido
    reg [24:0] inm_test;    //entrada
    wire [1:0] src_test;    //otra entrada
    wire [31:0] inmExt_test;    //salida

    //Iniciacialización del codigo  || UUT= unit under test
    SE SE_UUT(
        .inm(inm_test),  
        .src(src_test),
        .inmExt(inmExt_test)
    );
  
    initial begin       
        $dumpfile(`DUMPSTR("VCD_OUTPUT"));  //$dumpfile= palabra clave, donde vamos a guardar la salida de la prueba
        $dumpvars(0, SE_TB); //nombre del modulo a testear (este mismo PC_TB)
        //#1 tiempo de espera para la siguiente ejecución (1 unidad de tiempo)
        inm_test = 25'hFFFF;
        #2
        test_b = 32'h0;
        #3.5
        test_b = 32'hFFFFFFFF;

        #(DURATION)
        $finish;

    end

endmodule

