// Design Module

module full_adder(
  input in0, in1, cin,
  output sum, cout
);
assign sum= in0^ in1^ cin;
assign cout= (in0& in1)| ((in0^ in1)& cin);
endmodule

// Testbench Module

module tb_full_adder;
reg in0, in1, cin;
wire sum, cout;
integer i;

full_adder dut(.in0(in0), .in1(in1), .cin(cin), .sum(sum), .cout(cout));

initial begin
  for(i= 0; i< 2** 3; i+= 1) begin
    {in0, in1, cin}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_full_adder);
  $display("|TIME|IN0|IN1|Cin|SUM|Cout|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, in0, in1, cin, sum, cout);
end
endmodule
