// Design Module

module full_adder(
  input a, b, cin,
  output sum, cout
);
assign sum= a^ b^ cin;
assign cout= (a& b)| ((a^ b)& cin);
endmodule

// Testbench Module

module tb_full_adder;
reg a, b, cin;
wire sum, cout;
integer i;

full_adder dut(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

initial begin
  for(i= 0; i< 2** 3; i+= 1) begin
    {a, b, cin}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_full_adder);
  $display("|TIME|A|B|Cin|SUM|Cout|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, a, b, cin, sum, cout);
end
endmodule
