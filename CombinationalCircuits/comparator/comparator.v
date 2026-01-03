module comparartor(
    input a, b,
    output h, e, l
);
    assign h= a & ~b;
    assign e= ~(a ^ b);
    assign l= ~a & b;
endmodule

