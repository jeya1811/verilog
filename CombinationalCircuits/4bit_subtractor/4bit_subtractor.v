module full_subtractor(
    input x, y, bin,
    output diff, bout
);
    assign diff= x ^ y ^ bin;
    assign bout= (~x & y) | ((~x | y) & bin);
endmodule

module fourbit_subtractor(
    input [3:0] x, y,
    input bin, 
    output [3:0] diff, 
    output bout
);
    wire b1, b2, b3;
    full_subtractor FS0(x[0], y[0], bin, diff[0], b1);
    full_subtractor FS1(x[1], y[1], b1, diff[1], b2);
    full_subtractor FS2(x[2], y[2], b2, diff[2], b3);
    full_subtractor FS3(x[3], y[3], b3, diff[3], bout);
endmodule
