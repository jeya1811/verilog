`timescale 1ps/1ps

module tb_fullsubtractor;
reg a, b, borrow_in;
wire diff, borrow_out;

full_subtractor u_fullsubtractor(
    .a(a), .b(b), .borrow_in(borrow_in), .diff(diff), .borrow_out(borrow_out)
);

initial begin
    $dumpfile("fullsubtractor_wavees.vcd");
    $dumpvars(0, tb_fullsubtractor);
    $display("|A|B|BORROW_IN|DIFF|BORROW_OUT|");
    $display("|-|-|-|-|-|");
    for(integer i= 0; i< 8; i+= 1)begin
        {a, b, borrow_in}= i; #10;
        $display("|%b|%b|%b|%b|%b|", a, b, borrow_in, diff, borrow_out);
    end
    $finish;
end
endmodule