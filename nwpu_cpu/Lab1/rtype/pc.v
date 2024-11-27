/*
module pc(pc,clock,reset,npc);

output [31:0] pc;

input clock;

input reset;

input [31:0] npc;

注意：
    1.clock上升沿有效，reset低电平有效；
    2. reset信号有效时，pc复位为0x0000_3000；采用同步复位。
*/
module pc(pc, clock, reset, npc);
    output reg [31:0] pc;
    input clock;
    input reset;
    input [31:0] npc;

    always @(posedge clock) begin
        if (!reset)begin
            pc <= 32'h0000_3000;
        end 
        else begin
            pc <= npc;
        end
    end
endmodule