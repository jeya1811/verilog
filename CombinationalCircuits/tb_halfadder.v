`timescale 1ps/1ps

module tb_halfadder;
    reg a, b;
    wire sum, carry;

half_adder u_halfadder(
    .a(a), .b(b), .sum(sum), .carry(carry)
);

initial begin
    $dumpfile("halfadder_wave.vcd");
    $dumpvars(0, tb_halfadder);

    $display("A  B  SUM  CARRY");
    for(integer i= 0; i< 4; i+=1)begin
        {a, b}= i; #10
        $display("%b  %b    %b    %b", a, b, sum, carry);
    end
    $finish;
end
endmodule