`timescale 1ps/1ps

module tb_gates;
    reg a, b;
    wire c_and, c_or, c_not, c_nand, c_nor, c_xor, c_xnor;

and_gate u_and(
    .a(a), .b(b), .c(c_and)
);

or_gate u_or(
    .a(a), .b(b), .c(c_or)
);

not_gate u_not(
    .a(a), .b(c_not)
);

nand_gate u_nand(
    .a(a), .b(b), .c(c_nand)
);

nor_gate u_nor(
    .a(a), .b(b), .c(c_nor)
);

xor_gate u_xor(
    .a(a), .b(b), .c(c_xor)
);

xnor_gate u_xnor(
    .a(a), .b(b), .c(c_xnor)
);

initial begin
    $dumpfile("gates_wave.vcd");
    $dumpvars(0, tb_gates);

    $display("|A|B|AND|OR|NOT(A)|NAND|NOR|XOR|XNOR|");
    $display("|-|-|-|-|-|-|-|-|-|");

    a= 0; b= 0; #10;
    $display("|%b|%b|%b|%b|%b|%b|%b|%b|%b|", a, b, c_and, c_or, c_not, c_nand, c_nor, c_xor, c_xnor);
    a= 0; b= 1; #10;
    $display("|%b|%b|%b|%b|%b|%b|%b|%b|%b|", a, b, c_and, c_or, c_not, c_nand, c_nor, c_xor, c_xnor);
    a= 1; b= 0; #10; 
    $display("|%b|%b|%b|%b|%b|%b|%b|%b|%b|", a, b, c_and, c_or, c_not, c_nand, c_nor, c_xor, c_xnor);
    a= 1; b= 1; #10;
    $display("|%b|%b|%b|%b|%b|%b|%b|%b|%b|", a, b, c_and, c_or, c_not, c_nand, c_nor, c_xor, c_xnor);
    $finish;
end
endmodule
