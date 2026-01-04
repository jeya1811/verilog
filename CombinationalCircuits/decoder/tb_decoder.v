`timescale 1ps/1ps

module tb_decoder2to4;
    reg [1:0] x;
    wire [3:0] y;

decoder_2to4 u_dec2to4(
    .x(x), .y(y)
);

integer i;

initial begin
    $dumpfile("decoder4to2_waves.vcd");
    $dumpvars(0, tb_decoder2to4);
    $display("|X|Y|");
    $display("|-|-|");
    for(i= 0; i< 4; i+= 1)begin
        x= i; #10;
        $display("|%2b|%4b|", x, y);
    end
    $finish;
end
endmodule