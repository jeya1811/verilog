// Design Module

module full_adder(
  input ip0, ip1, cip,
  output sum, cop
);
assign sum= ip0^ ip1^ cip;
assign cop= (ip0& ip1)| ((ip0^ ip1)& cip);
endmodule

// Testbench Module

module tb_full_adder;
reg ip0, ip1, cip;
wire sum, cop;
integer i;

full_adder dut(.ip0(ip0), .ip1(ip1), .cip(cip), .sum(sum), .cop(cop));

initial begin
  for(i= 0; i< 2** 3; i+= 1) begin
    {ip0, ip1, cip}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_full_adder);
  $display("|TIME|IP0|IP1|Cip|SUM|Cop|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, ip0, ip1, cip, sum, cop);
end
endmodule
