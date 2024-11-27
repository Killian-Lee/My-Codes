`include "header.v"

module alu (c, a, b, aluop);
    output reg [31:0] c;
    input signed [31:0] a;
    input signed [31:0] b;
    //
    input [5:0] aluop;

    always @ (*) begin
        case (aluop)
            `ADDU : c = a + b;
            `SUBU : c = a - b;
            `ADD  : c = a + b;
            `AND  : c = a & b;
            `OR   : c = a | b;
            `SLT  : c = ($signed(a) < $signed(b)) ? 1 : 0;  
            `LUI  : c = {b[15:0],{16{1'b0}}};
            //default: c <= 32'b0;
        endcase
    end
endmodule
