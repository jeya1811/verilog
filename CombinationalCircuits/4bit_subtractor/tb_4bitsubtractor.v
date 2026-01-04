`timescale 1ps/1ps

module tb_4bitsubtractor;
    reg [3:0] x, y;
    reg bin;
    wire [3:0] diff;
    wire bout;

fourbit_subtractor u_4bitsubtractor(
    .x(x), .y(y), .bin(bin), .diff(diff), .bout(bout)
);

initial begin
    $dumpfile("4bitsubtractor_waves.vcd");
    $dumpvars(0, tb_4bitsubtractor);
    $display("|X|Y|Bin|DIFF|Bout|");
    $display("|-|-|-|-|-|");
    for(integer i= 0; i< 16; i+= 1)begin
        for(integer j= 0; j< 16; j+= 1)begin
            x= i; y= j; bin= 0; #10;
            $display("|%b|%b|%b|%b|%b|", x, y, bin, diff, bout);
            x= i; y= j; bin= 1; #10;
            $display("|%b|%b|%b|%b|%b|", x, y, bin, diff, bout);
        end
    end
    $finish;
end
endmodule