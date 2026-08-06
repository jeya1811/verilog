// Design Module

module full_adder(
  input a, b, cin,
  output sum, cout
);
assign sum= a^ b^ cin;
assign cout= (a& b)| ((a^ b)& cin);
endmodule

module ripple_carry_adder #(parameter Width= 1)(
  input [Width-1:0] a, b,
  input cin,
  output [Width-1:0] sum,
  output cout
);
wire [Width:0] carry;
assign carry[0]= cin;
assign cout= carry[Width];
genvar i;
generate
  for(i= 0; i< Width; i= i+ 1) begin: fa
    full_adder u(.a(a[i]), .b(b[i]), .cin(carry[i]), .sum(sum[i]), .cout(carry[i+1]));
  end
endgenerate
endmodule

// Testbench Module

module tb;
localparam Width= 2;
reg [Width-1:0] a, b;
reg cin;
wire [Width-1:0] sum;
wire cout;
integer i;

ripple_carry_adder #(.Width(Width)) dut(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

initial begin
  for(i= 0; i< 2** (2* Width+ 1); i+= 1) begin
    {a, b, cin}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb);
  $display("Bit Width= %0d", Width);
  $display("|TIME|A|B|Cin|SUM|Cout|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, a, b, cin, sum, cout);
end
endmodule
