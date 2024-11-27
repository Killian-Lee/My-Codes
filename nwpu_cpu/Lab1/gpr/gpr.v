/*
module gpr(a,b,clock,reg_write,num_write,rs,rt,data_write);

output [31:0] a;  

output [31:0] b;

input clock;

input reg_write;

input [4:0] rs; //读寄存器1

input [4:0] rt; //读寄存器2

input [4:0] num_write; //写寄存器

input [31:0] data_write; //写数据

reg [31:0] gp_registers[31:0];  //32个寄存器

提示：   gp_registers[0] 永远等于0
*/
module gpr(a, b, clock, reg_write, num_write, rs, rt,data_write);
    output [31:0] a;  // 读寄存器1 的值
    output [31:0] b;  // 读寄存器2 的值
    input clock;
    input reg_write ; // 写使能信号，1有效，0无效
    input [4:0] rs;   // 读寄存器1的编号
    input [4:0] rt;   // 读寄存器2的编号
    input [4:0] num_write;     // 写寄存器的编号
    input [31:0] data_write;   // 写数据
    reg [31:0] gp_registers[31:0]; // 32个寄存器

    /******1. 写寄存器 在clock上升沿，如果reg_write有效，寄存器堆[num_write] = data_write ******/
    always@(posedge clock)
    begin
        if(reg_write)
        begin
            if (num_write != 0)
            begin
                gp_registers[num_write] <= data_write;
            end
        end
    end

    /******2. 读寄存器 a/b = 寄存器堆[rs/rt]******/
    assign a = gp_registers[rs];
    assign b = gp_registers[rt];

endmodule