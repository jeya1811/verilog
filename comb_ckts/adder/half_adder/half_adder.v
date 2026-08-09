// Design Module

module half_adder(
  input ip0, ip1,
  output sum, cop
);
assign sum= ip0^ ip1;
assign cop= ip0& ip1;
endmodule

// Testbench Module

module tb_half_adder;
reg ip0, ip1;
wire sum, cop;
integer i;

half_adder dut(.ip0(ip0), .ip1(ip1), .sum(sum), .cop(cop));

initial begin
  for(i= 0; i< 2** 2; i+= 1) begin
    {ip0, ip1}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_half_adder);
  $display("|TIME|IP0|IP1|SUM|Cop|");
  $display("|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|", $time, ip0, ip1, sum, cop);
end
endmodule
