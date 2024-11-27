/*
module alu(c,a,b);

output [31:0] c;

input [31:0] a;

input [31:0] b;
*/
module alu (c, a, b, aluop);
    output reg [31:0] c;
    input signed [31:0] a;
    input signed [31:0] b;
    //
    input [3:0] aluop;

    always @ (*) begin
        case (aluop)
            4'b0000: c = a + b;
            4'b0001: c = a - b;
            4'b0010: c = $signed(a) + $signed(b);
            4'b0011: c = a & b;
            4'b0100: c = a | b;
            4'b0101: c = ($signed(a) < $signed(b)) ? 1 : 0;  
            default: c = 32'b0;
        endcase
    end
endmodule
