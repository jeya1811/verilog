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
    $display("X     Y");
    for(i= 0; i< 4; i+= 1)begin
        x= i; #10;
        $display("%d %d   %d %d %d %d", x[1], x[0], y[3], y[2], y[1], y[0]);
    end
    $finish;
end
endmodule