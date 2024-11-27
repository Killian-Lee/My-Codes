module ctrl (
    output reg reg_write,
    output reg [3:0] aluop,
    input [5:0] op,
    input [5:0] funct
);
    always @ (*) begin

        reg_write = 0;
        aluop = 4'b0000;

        if (op == 6'b000000) begin
            case(funct)
                // addu 100001 --> 0000
                6'b100001: begin
                    reg_write = 1;
                    aluop = 4'b0000;
                end
                // subu 100011 --> 0001
                6'b100011: begin
                    reg_write = 1;
                    aluop = 4'b0001;
                end
                // add  100000 --> 0010
                6'b100000: begin
                    reg_write = 1;
                    aluop = 4'b0010;
                end
                // and  100100 --> 0011
                6'b100100: begin
                    reg_write = 1;
                    aluop = 4'b0011;
                end
                // or   100101 --> 0100
                6'b100101: begin
                    reg_write = 1;
                    aluop = 4'b0100;
                end
                //slt   101010 --> 0101
                6'b101010: begin
                    reg_write = 1;
                    aluop = 4'b0101;
                end
                default: begin
                    reg_write = 0;
                    aluop = 4'b0000;
                end
            endcase    
        end
    end 
endmodule
