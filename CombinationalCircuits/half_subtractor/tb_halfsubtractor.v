`timescale 1ps/1ps

module tb_halfsubtractor;
reg a, b;
wire diff, borrow;

half_subtractor u_halfsubtractor(
    .a(a), .b(b), .diff(diff), .borrow(borrow)
);

initial begin
    $dumpfile("halfsubtractor_waves.vcd");
    $dumpvars(0, tb_halfsubtractor);
    $display("|A|B|DIFF|BORROW|");
    $display("|-|-|-|-|");
    for(integer i= 0; i< 4; i+= 1)begin
        {a, b}= i; #10;
        $display("|%b|%b|%b|%b|", a, b, diff, borrow);
    end
    $finish;
end
endmodule