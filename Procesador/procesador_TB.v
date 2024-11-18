`default_nettype none
`define DUMPSTR "procesador_TB.vcd"
`timescale 100 ns / 10 ns

module procesador_TB;
    parameter DURATION = 100;

    reg clk_test = 0;
    reg reset_test = 0;  // Señal de reset

    // Generación del reloj
    always #1 clk_test = ~clk_test;

    // Instancia del procesador
    procesador procesador_UUT (
        .clk(clk_test),
        .reset(reset_test)
    );

    // Inicialización de señales
    integer i;

    initial begin
        $dumpfile(`DUMPSTR);  
        $dumpvars(0, procesador_TB);  // Muestra todas las señales para depuración

        // Inicialización de señales
        reset_test = 1;  // Activar reset al principio

        // Dar un ciclo de reloj con reset activado para asegurar la correcta inicialización
        #5 reset_test = 0;  // Desactivar el reset después de 5 ns

        // Ejecutar la simulación por DURATION ciclos de reloj

        // Al finalizar, imprimir los valores del banco de registros
        $display("Contenido de los registros después de la simulación:");

        // Itera sobre los 32 registros y los imprime
        #9
        for (i = 0; i < 32; i = i + 1) begin
            // Imprime el valor de cada registro
            $display("Registro %d: 0x%h", i, procesador_UUT.datapath_inst.BR_inst.BankReg[i]);
        end
        
        #(DURATION);
        $finish;  // Termina la simulación
    end
endmodule
