`timescale 1ps/1ps

module tb_fulladder;
    reg a, b, cin;
    wire sum, cout;

full_adder u_fulladder(
    .a(a), .b(b), .cin(cin), .sum(sum), .cout(cout)
);

initial begin
    $dumpfile("fulladder_wave.vcd");
    $dumpvars(0, tb_fulladder);

    $display("A  B  CIN  SUM  COUT");
    for(integer i= 0; i< 8; i= i+1)begin
        {a, b, cin}= i; #10;
        $display("%b  %b  %b  %b  %b", a, b, cin, sum, cout);
    end
    $finish;
end
endmodule