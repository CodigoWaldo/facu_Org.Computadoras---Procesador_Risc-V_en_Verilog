`default_nettype none
`define DUMPSTR "procesador_TB.vcd"
`timescale 100 ns / 10 ns

module procesador_TB;
    parameter DURATION = 250;

    reg clk_test = 1;
    reg reset_test = 0;  // Señal de reset

    // Generación del reloj
    always #1 clk_test = ~clk_test;

    // Instancia del procesador
    procesador procesador_UUT (
        .clk(clk_test),
        .reset(reset_test)
    );


    integer i;

    initial begin
        $dumpfile(`DUMPSTR);  
        $dumpvars(0, procesador_TB);          

        // Para observar los valores de la memoria y registros en el simulador gtkwave.
        for (i = 0; i < 32; i = i + 1) begin           
            $dumpvars(0, procesador_UUT.DM_inst.MEM[i]);
        end            
        for (i = 0; i < 32; i = i + 1) begin            
            $dumpvars(0,procesador_UUT.datapath_inst.BR_inst.BankReg[i]);
        end

        #0
        reset_test = 1;  // Activar reset al principio 
        #2
        reset_test = 0;        
        
        
        #(DURATION);
        $finish;  
    end
endmodule
