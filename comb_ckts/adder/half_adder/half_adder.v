// Design Module

module half_adder(
  input in0, in1,
  output sum, cout
);
assign sum= in0^ in1;
assign cout= in0& in1;
endmodule

// Testbench Module

module tb_half_adder;
reg in0, in1;
wire sum, cout;
integer i;

half_adder dut(.in0(in0), .in1(in1), .sum(sum), .cout(cout));

initial begin
  for(i= 0; i< 2** 2; i+= 1) begin
    {in0, in1}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_half_adder);
  $display("|TIME|IN0|IN1|SUM|Cout|");
  $display("|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|", $time, in0, in1, sum, cout);
end
endmodule
