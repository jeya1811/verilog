// Design Module

module full_adder(
  input ip0, ip1, cip,
  output sum, cop
);
assign sum= ip0^ ip1^ cip;
assign cop= (ip0& ip1)| ((ip0^ ip1)& cip);
endmodule

module ripple_carry_adder #(parameter Width= 1)(
  input [Width-1:0] ip0, ip1,
  input cip,
  output [Width-1:0] sum,
  output cop
);
wire [Width:0] carry;
assign carry[0]= cip;
assign cop= carry[Width];
genvar i;
generate
  for(i= 0; i< Width; i= i+ 1) begin: fa
    full_adder u(.ip0(ip0[i]), .ip1(ip1[i]), .cip(carry[i]), .sum(sum[i]), .cop(carry[i+1]));
  end
endgenerate
endmodule

// Testbench Module

module tb_ripple_carry_adder;
localparam Width= 2;
reg [Width-1:0] ip0, ip1;
reg cip;
wire [Width-1:0] sum;
wire cop;
integer i;

ripple_carry_adder #(.Width(Width)) dut(.ip0(ip0), .ip1(ip1), .cip(cip), .sum(sum), .cop(cop));

initial begin
  for(i= 0; i< 2** (2* Width+ 1); i+= 1) begin
    {ip0, ip1, cip}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_ripple_carry_adder);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IP0|IP1|Cip|SUM|Cop|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, ip0, ip1, cip, sum, cop);
end
endmodule
