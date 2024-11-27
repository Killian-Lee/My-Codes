module dm(data_out,clock,mem_write,address,data_in); 
    output [31:0] data_out; 
    input clock;
    input mem_write;
    input [31:0] address;
    input [31:0] data_in;
    reg [31:0] data_memory[1023:0]; //4KB数据存储器
    //1024个存储单元，每个存储单元为32位=4字节=1字。
    
    always@(posedge clock)begin
        if(mem_write)
        begin
            data_memory[address[11:0]>>2] <= data_in;
        end
    end

endmodule