// Design Module

module full_subtractor(
  input ip0, ip1, bip,
  output diff, bop
);
assign diff= ip0^ ip1^ bip;
assign bop= (~ip0& ip1)| ((ip0~^ ip1)& bip);
endmodule

// Testbench Module

module tb_full_subtractor;
reg ip0, ip1, bip;
wire diff, bop;
integer i;

full_subtractor dut(.ip0(ip0), .ip1(ip1), .bip(bip), .diff(diff), .bop(bop));

initial begin
  for(i= 0; i< 2** 3; i+= 1) begin
    {ip0, ip1, bip}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_full_subtractor);
  $display("|TIME|IP0|IP1|Bip|DIFF|Bop|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, ip0, ip1, bip, diff, bop);
end
endmodule
