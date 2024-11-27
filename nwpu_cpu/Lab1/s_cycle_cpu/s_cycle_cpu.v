/*
利用实现的各个基本模块，实现一个能执行addu指令的单周期CPU。
顶层模块定义如下：
module s_cycle_cpu(clock,reset);

//输入

input clock;

input reset;
*/
module s_cycle_cpu(clock,reset);
    input clock;
    input reset;

    wire [31:0] _pc;
    wire [31:0] _npc;
    wire [31:0] _instruction;
    wire [31:0] _a;
    wire [31:0] _b;
    wire [31:0] _data_write;
    wire [4:0] _rs;
    wire [4:0] _rt;
    wire [4:0] _rd;
    wire _reg_write;

    // get PC then PC+4
    pc PC ( .pc(_pc),
            .npc(_npc),
            .clock(clock),
            .reset(reset)
          );
    assign _npc = _pc + 32'h00000004;
    
    // use pc to get instruction
    im IM ( .instruction(_instruction),
            .pc(_pc)
          );
    
    // decode and get source and target rigister
    assign _rs = _instruction[25:21];
    assign _rt = _instruction[20:16];
    assign _rd = _instruction[15:11];

    // decode and write back
    gpr GPR (.a(_a),
             .b(_b),
             .rs(_rs),
             .rt(_rt),
             .num_write(_rd),
             .data_write(_data_write),
             .reg_write(1'h1),
             .clock(clock)
            );
    // get result
    alu ALU (.c(_data_write),
             .a(_a),
             .b(_b)
            );
endmodule