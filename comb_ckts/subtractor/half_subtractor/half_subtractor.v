// Design Module

module half_subtractor(
  input ip0, ip1,
  output diff, bop
);
assign diff= ip0^ ip1;
assign bop= ~ip0& ip1;
endmodule

// Testbench Module

module tb_half_subtractor;
reg ip0, ip1;
wire diff, bop;
integer i;

half_subtractor dut(.ip0(ip0), .ip1(ip1), .diff(diff), .bop(bop));

initial begin
  for(i= 0; i< 2** 2; i+= 1) begin
    {ip0, ip1}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_half_subtractor);
  $display("|TIME|IP0|IP1|DIFF|Bop|");
  $display("|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|", $time, ip0, ip1, diff, bop);
end
endmodule
