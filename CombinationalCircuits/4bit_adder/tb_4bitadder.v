`timescale 1ps/1ps

module tb_4bitadder;
    reg [3:0] a, b;
    reg cin;
    wire [3:0] sum;
    wire cout;

fourbit_adder u_4bit(
    .a(a), .b(b), .cin(cin), .sum(sum), .cout(cout)
);

integer i, j;

initial begin
    $dumpfile("4bitadder_wave.vcd");
    $dumpvars(0, tb_4bitadder);
    $display("|A|B|Cin|SUM|Cout|");
    $display("|--|--|--|--|--|");
    for(i= 0; i< 16; i+= 1)begin
        for(j= 0; j< 16; j+= 1)begin
            a= i; b= j; cin= 0; #10;
            $display("|%b|%b|%b|%b|%b|", a, b, cin, sum, cout);
            a= i; b= j; cin= 1; #10;
            $display("|%b|%b|%b|%b|%b|", a, b, cin, sum, cout);
        end
    end
    $finish;
end
endmodule
