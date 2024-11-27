//operation
`define ADDU 6'b000001
`define SUBU 6'b000010
`define ADD  6'b000011
`define AND  6'b000100
`define OR   6'b000101
`define SLT  6'b000110

`define ADDI  6'b000111
`define ADDIU 6'b001000
`define ANDI  6'b001001
`define ORI   6'b001010
`define LUI   6'b001011

`define LW    6'b001100
`define SW    6'b001101
//LUI:作用是将立即数加载到寄存器的高 16 位，并将低 16 位置为 0

//opcode
`define OP_R    6'b000000
//`define OP_I    6'b111111

`define OP_ADDI  6'b001000  //add
`define OP_ADDIU 6'b001001  //addu
`define OP_ANDI  6'b001100  //and
`define OP_ORI   6'b001101  //or
`define OP_LUI   6'b001111  //lui

`define OP_LW    6'b100011  
`define OP_SW    6'b101011


