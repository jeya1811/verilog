// Design Module

module half_subtractor(
  input in0, in1,
  output diff, bout
);
assign diff= in0^ in1;
assign bout= ~in0& in1;
endmodule

// Testbench Module

module tb_half_subtractor;
reg in0, in1;
wire diff, bout;
integer i;

half_subtractor dut(.in0(in0), .in1(in1), .diff(diff), .bout(bout));

initial begin
  for(i= 0; i< 2** 2; i+= 1) begin
    {in0, in1}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_half_subtractor);
  $display("|TIME|IN0|IN1|DIFF|Bout|");
  $display("|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|", $time, in0, in1, diff, bout);
end
endmodule
