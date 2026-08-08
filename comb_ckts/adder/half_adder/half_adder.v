// Design Module

module half_adder(
  input a, b,
  output sum, cout
);
assign sum= a^ b;
assign cout= a& b;
endmodule

// Testbench Module

module tb_half_adder;
reg a, b;
wire sum, cout;
integer i;

half_adder dut(.a(a), .b(b), .sum(sum), .cout(cout));

initial begin
  for(i= 0; i< 2** 2; i+= 1) begin
    {a, b}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_half_adder);
  $display("|TIME|A|B|SUM|Cout|");
  $display("|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|", $time, a, b, sum, cout);
end
endmodule
