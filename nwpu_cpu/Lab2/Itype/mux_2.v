module mux_2 #(parameter width = 6)(
    output [width-1:0]c,
    input  [width-1:0]a,
    input  [width-1:0]b,
    input  sel
);
    assign c = sel ? a : b;
    
endmodule
