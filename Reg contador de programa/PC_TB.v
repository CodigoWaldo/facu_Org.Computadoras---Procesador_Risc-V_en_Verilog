`default_nettype none
`define DUMPSTR(X) "PC_TB.vcd"
`timescale 100 ns / 10 ns //valor de unidad de tiempo / unidad de precision

module PC_TB;
    parameter DURATION =  10; //duracion total del test (10 seg)

    //se define el clock y cada cuanto cambia su valor (cada 50 ns)
    reg clk_test = 0;
    always #1 clk_test = ~clk_test; //alterna a su opuesto, de 0 a 1 y viceversa 

    //señales que enviará el test
    // wire test_a; //entrada del clk ya definido
    reg [31:0] test_b;    //entrada
    wire [31:0] test_s;    //salida

    //Iniciacialización del codigo  || UUT= unit under test
    PC PC_UUT(
        .clk(clk_test),    //clock del pc
        .pcNext(test_b),
        .pc(test_s)
    );
  
    initial begin       
        $dumpfile(`DUMPSTR("VCD_OUTPUT"));  //$dumpfile= palabra clave, donde vamos a guardar la salida de la prueba
        $dumpvars(0, PC_TB); //nombre del modulo a testear (este mismo PC_TB)
        //#1 tiempo de espera para la siguiente ejecución (1 unidad de tiempo)
        test_b = 32'hFFFFFFFF;
        #2
        test_b = 32'h0;
        #3.5
        test_b = 32'hFFFFFFFF;

        #(DURATION)
        $finish;

    end

endmodule

