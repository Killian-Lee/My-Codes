`include "header.v"

module ctrl (
    output [5:0] aluop,
    output ext, //立即数拓展信号，0拓展or有符号拓展
    output IorR,
    output reg_write,
    output men_write,
    output s_data_write, //写数据寄存器的信号
    input [5:0] op,
    input [5:0] funct
);
    assign IorR = (op==`OP_R) ? 0 : 1;
    
    assign aluop = 
        (op==`OP_R && funct==6'b100001)?`ADDU:
        (op==`OP_R && funct==6'b100011)?`SUBU:
        (op==`OP_R && funct==6'b100000)?`ADD:
        (op==`OP_R && funct==6'b100100)?`AND:
        (op==`OP_R && funct==6'b100101)?`OR:
        (op==`OP_R && funct==6'b101010)?`SLT:
        (op==`OP_ADDI)                 ?`ADD:
        (op==`OP_ADDIU)                ?`ADDU:
        (op==`OP_ORI)                  ?`OR:
        (op==`OP_ANDI)                 ?`AND:

        (op==`OP_LW)                   ?`LW:
        (op==`OP_SW)                   ?`SW:
                                        `LUI;
    
    assign ext = (op==`OP_ADDI)        ?1'b1:
                 (op==`OP_ADDIU)       ?1'b1:
                 (op==`OR)             ?1'b0:

                 (op==`LW)             ?1'b1:
                 (op==`SW)             ?1'b1:
                                        1'b0;

    assign reg_write = (op!=`OP_SW);  //SW写的是内存不是reg
    assign men_write = (op==`OP_SW);
    assign s_data_write = (op==`OP_LW);
    //assign s_num_write = (op==`OP_R) ? 1'b1 : 1'b0;
    //assign s_b = (op==`OP_R) ? 1'b0 : 1'b1;
endmodule
