/*
利用实现的各个基本模块，实现一个能执行addu指令的单周期CPU。
顶层模块定义如下：
module s_cycle_cpu(clock,reset);

//输入

input clock;

input reset;
*/
`include "header.v"
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
    wire [5:0] _op;
    wire [5:0] _aluop;
    wire [5:0] _funct;
    wire [15:0] _imm;
    wire [31:0] _imm_ext;
    wire _IorR;
    wire _ext;

    wire [5:0] _target_reg;   // 目标寄存器：R型为rd，I型为rt，此处通过一个mux_2选择目标寄存器
    wire [31:0] _2th_num;     // 第二个操作数：来自寄存器 还是 来自符号扩展的立即数

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
    
    assign _op = _instruction[31:26];
    assign _funct = _instruction[5:0];
    assign _imm = _instruction[15:0];

    // decode and write back
    gpr GPR (.a(_a),
             .b(_b),
             .rs(_rs),
             .rt(_rt),
            // .num_write(_rd),
             .num_write(_target_reg),
             .data_write(_data_write),
             .reg_write(1'b1),
             .clock(clock)
    );
    // get result
    alu ALU (.c(_data_write),
             .a(_a),
            //.b(_b),
             .b(_2th_num),
             .aluop(_aluop)
    );
    
    ctrl CTRL (
            .aluop(_aluop),
            .op(_op),
            .funct(_funct),
            .ext(_ext),
            .IorR(_IorR)
    );

    extend EXTEND(
            .imm(_imm),
            .ext(_ext),
            .imm_out(_imm_ext)
    );

    //I型：选择rt,     R型：选择rd
    mux_2 #(.width(6))MUX_2_A(
            .a(_rt),
            .b(_rd),
            .c(_target_reg),
            .sel(_IorR)
    );

    //I型：选择立即数， R型：选择寄存器的数
    mux_2 #(.width(32))MUX_2_B(
            .a(_imm_ext),
            .b(_b),
            .c(_2th_num),
            .sel(_IorR)
    );
endmodule