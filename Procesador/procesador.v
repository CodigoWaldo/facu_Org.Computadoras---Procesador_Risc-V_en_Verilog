`include "Datapath/datapath.v"
`include "Unidad de control/UC.v"

module procesador (
    input wire clk,
    //input wire reset, ?
);
  // Instancia del datapath
    datapath datapath_inst (
        clk, pcSrc, result_src, memWrite, aluSrc, immSrc, regWrite, aluControl,
        f7, f3, op, zero
    );

    // Instancia de la unidad de control
    UC UC_inst (
        op, f3, f7, zero,
        pcSr, result_src, memWrite, aluSrc, immSrc, regWrite, aluControl
    );

endmodule