`timescale 1ps/1ps

module tb_binaryBCD;
    reg [7:0] x;
    wire [3:0] tens, ones;

binarytoBCD u_binarytoBCD(
    .x(x), .tens(tens), .ones(ones)
);
integer i;
initial begin
    $dumpfile("binaryBCD_waves.vcd");
    $dumpvars(0, tb_binaryBCD);
    $display("|DECIMAL|BINARY|BCD|");
    $display("|-|-|-|");
    for(i= 0; i< 100; i+= 1)begin
        x= i; #10;
        $display("|%d|%8b|%4b %4b|", x, x, tens, ones);
    end
    $finish;
end
endmodule