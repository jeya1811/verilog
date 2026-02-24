`timescale 1ps/1ps

module tb_binary7segment;
reg [7:0] binary;
wire [3:0] bcd_tens, bcd_ones;
wire [6:0] seg_tens, seg_ones;

binarytoBCD u_binarytoBCD(
    .binary(binary), .bcd_tens(bcd_tens), .bcd_ones(bcd_ones)
);
BCDto7segment tens_bcd7segment(
    .BCD(bcd_tens), .seg(seg_tens)
);
BCDto7segment ones_bcd7segment(
    .BCD(bcd_ones), .seg(seg_ones)
);
integer i;
initial begin
    $dumpfile("binary7segment_waves.vcd");
    $dumpvars(0, tb_binary7segment);
    $display("|DECIMAL|BINARY|BCD|7-SEGMENT|");
    $display("|-|-|-|-|");
    $display("||||abcdefg abcdefg|");
    for(i= 0; i< 100; i+= 1)begin
        binary= i; #10;
        $display("|%d|%8b|%4b %4b|%4b %4b|", binary, binary, bcd_tens, bcd_ones, seg_tens, seg_ones);
    end
    $finish;
end
endmodule
