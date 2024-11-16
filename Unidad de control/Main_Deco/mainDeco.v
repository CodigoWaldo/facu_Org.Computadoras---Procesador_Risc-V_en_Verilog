module main_deco(
    input [6:0] op,         // opcode

    output wire branch,     // branch signal
    output wire jump,       // jump signal
    output [1:0] resSrc,    // result source
    output wire memWrite,   // memory write signal
    output wire aluSrc,     // ALU source signal
    output [1:0] immSrc,    // immediate source
    output wire regWrite,   // register write signal
    output [1:0] aluOp      // ALU operation
);


// Auxvars

reg branchAux = 0;          // auxiliary variable for branch signal
reg jumpAux = 0;            // auxiliary variable for jump signal
reg [1:0] resSrcAux = 0;    // auxiliary variable for result source
reg memWriteAux = 0;        // auxiliary variable for memory write signal
reg aluSrcAux = 0;          // auxiliary variable for ALU source signal
reg [1:0] immSrcAux = 0;    // auxiliary variable for immediate source
reg regWriteAux = 0;        // auxiliary variable for register write signal
reg [1:0] aluOpAux = 0;     // auxiliary variable for ALU operation

always @(*)
begin
    case (op)
        7'd3:      //lw
        begin
            branchAux = 0;
            resSrcAux = 2'b01; // load word instruction
            memWriteAux = 0;
            aluSrcAux = 1;
            immSrcAux = 2'b00;
            regWriteAux = 1;
            aluOpAux = 2'b00;
        end
        7'd35:     //sw
        begin
            branchAux = 0;
            memWriteAux = 1; // store word instruction
            aluSrcAux = 1;
            immSrcAux = 2'b01;
            regWriteAux = 0;
            aluOpAux = 2'b00;
        end
        7'd51:     //R-Type
        begin
            branchAux = 0;
            resSrcAux = 2'b00;
            memWriteAux = 0;
            aluSrcAux = 0;
            regWriteAux = 1;
            aluOpAux = 2'b10; // R-type instruction
        end
        7'd99:     //beq
        begin
            branchAux = 1; // branch if equal instruction
            memWriteAux = 0;
            aluSrcAux = 0;
            immSrcAux = 2'b10;
            regWriteAux = 0;
            aluOpAux = 2'b01;
        end
        7'd19:     //I-Type
        begin
            branchAux = 0;
            resSrcAux = 2'b00;
            memWriteAux = 0;
            aluSrcAux = 1;
            immSrcAux = 2'b00;
            regWriteAux = 1;
            aluOpAux = 2'b10; // I-type instruction
        end
        7'd111:        //jal
        begin
            branchAux = 0;
            jumpAux = 1; // jump and link instruction
            resSrcAux = 2'b10;
            memWriteAux = 0;
            immSrcAux = 2'b11;
            regWriteAux = 1;
        end
    endcase
end

assign branch = branchAux;
assign jump = jumpAux;
assign resSrc = resSrcAux;
assign memWrite = memWriteAux;
assign aluSrc = aluSrcAux;
assign immSrc = immSrcAux;
assign regWrite = regWriteAux;
assign aluOp = aluOpAux;

endmodule