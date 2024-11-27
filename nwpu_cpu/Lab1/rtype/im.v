/*
im: Instruction Memory

module im(instruction,pc);
output [31:0] instruction;
input [31:0] pc;
reg [31:0] ins_memory[1023:0]; //4k指令存储器

说明：im模块的输入pc为32位，但指令存储器只有4kB大小
    所以取指令时只取pc的低12位作为地址。
*/

module im(instruction, pc);
    output [31:0] instruction;       // 32位指令输出
    input [31:0] pc;                 // 32位地址输入
    
    // 定义指令存储器
    reg [31:0] ins_memory[1023:0];   // 1024 * 32 位存储器

/************取指令：instruction = 指令寄存器************/
    assign instruction = ins_memory[pc[11:0] >> 2];  // 除以4实现字对齐
endmodule
