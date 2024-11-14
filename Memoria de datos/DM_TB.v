`default_nettype none
`define DUMPSTR "DM_TB.vcd"
`timescale 100 ns / 10 ns

module DM_TB;
    parameter DURATION =  10;
    reg clk_test = 0;    
    always #1 clk_test = ~clk_test;
    
    reg              we_test;    
    reg [4:0]        adm_test;
    reg [31:0]       wd_test; 

    wire [31:0]       rd_test;

    DM DM_UUT(
        .clk(clk_test),
        .we(we_test),
        .addressDM(adm_test),
        .wd(wd_test),         
        .rd(rd_test)    
    );
  
    initial begin    
        DM_UUT.MEM[0] = 32'h01230000;
        DM_UUT.MEM[1] = 32'h12311111;
        DM_UUT.MEM[2] = 32'h01232222;
        DM_UUT.MEM[3] = 32'h01233333;
        adm_test= 5'b00001;
        wd_test= 32'h5633453;
        we_test= 1'b0;

        $dumpfile(`DUMPSTR);  
        $dumpvars(0, DM_TB);

        #5
        we_test=1'b1;

        #(DURATION)
        $finish;
    end
endmodule



