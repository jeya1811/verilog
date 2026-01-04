`timescale 1ps/1ps

module tb_binaryBCD;
    reg [7:0] x;
    wire [3:0] tens, ones;
    wire [7:0] y;

binarytoBCD u_binarytoBCD(
    .x(x), .tens(tens), .ones(ones)
);
BCDtobinary u_BCDtobinary(
    .tens(tens), .ones(ones), .y(y)
);
integer i;
initial begin
    $dumpfile("binaryBCD_waves.vcd");
    $dumpvars(0, tb_binaryBCD);
    $display("|DECIMAL|BINARY-ip|BCD|BINARY-op|");
    $display("|-|-|-|-|");
    for(i= 0; i< 100; i+= 1)begin
        x= i; #10;
        $display("|%d|%8b|%4b %4b|%8b|", x, x, tens, ones, y);
    end
    $finish;
end
endmodule