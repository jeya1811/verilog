`timescale 1ps/1ps
module tb_comparator;
    reg a, b;
    wire h, e, l;

comparartor u_comparator(
    .a(a), .b(b), .h(h), .e(e), .l(l)
);
integer i, j;

initial begin
    $dumpfile("comparator_waves.vcd");
    $dumpvars(0, tb_comparator);
    $display("A   B   H  E  L");
    for(i= 0; i< 2; i+= 1)begin
        for(j= 0; j< 2; j+= 1)begin
            a= i; b= j; #10;
            $display("%d %d  %d  %d  %d", a, b, h, e, l);
        end
    end
    $finish;
end
endmodule
        