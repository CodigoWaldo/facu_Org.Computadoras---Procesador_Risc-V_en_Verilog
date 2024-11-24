`default_nettype none
`define DUMPSTR "procesador_TB.vcd"
`timescale 100 ns / 10 ns

module procesador_TB;
    parameter DURATION = 100;

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
        
        #99
        $display("Contenido de la memoria de instruccines:");        
        for (i = 0; i < 32; i = i + 1) begin            
            $display("instruction memory %d: 0x%h", i, procesador_UUT.datapath_inst.mem_instr_inst.memory[i]);
        end        
        $display("Contenido de la memoria de datos:");
        for (i = 0; i < 32; i = i + 1) begin           
            $display("Data memory %d: 0x%h", i, procesador_UUT.DM_inst.MEM[i]);
        end     
        $display("Contenido de los registros:");        
        for (i = 0; i < 32; i = i + 1) begin            
            $display("Register %d: 0x%h", i, procesador_UUT.datapath_inst.BR_inst.BankReg[i]);
        end
           


        #(DURATION);
        $finish;  
    end
endmodule
