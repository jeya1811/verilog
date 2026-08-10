// Design Module

module full_subtractor(
  input in0, in1, bin,
  output diff, bout
);
assign diff= in0^ in1^ bin;
assign bout= (~in0& in1)| ((in0~^ in1)& bin);
endmodule

// Testbench Module

module tb_full_subtractor;
reg in0, in1, bin;
wire diff, bout;
integer i;

full_subtractor dut(.in0(in0), .in1(in1), .bin(bin), .diff(diff), .bout(bout));

initial begin
  for(i= 0; i< 2** 3; i+= 1) begin
    {in0, in1, bin}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_full_subtractor);
  $display("|TIME|IN0|IN1|Bin|DIFF|Bout|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, in0, in1, bin, diff, bout);
end
endmodule
