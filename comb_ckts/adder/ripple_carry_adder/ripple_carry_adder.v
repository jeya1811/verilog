// Design Module

module full_adder(
  input in0, in1, cin,
  output sum, cout
);
assign sum= in0^ in1^ cin;
assign cout= (in0& in1)| ((in0^ in1)& cin);
endmodule

module ripple_carry_adder #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
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
    full_adder u(.in0(in0[i]), .in1(in1[i]), .cin(carry[i]), .sum(sum[i]), .cout(carry[i+1]));
  end
endgenerate
endmodule

// Testbench Module

module tb_ripple_carry_adder;
localparam Width= 4;
reg [Width-1:0] in0, in1;
reg cin;
wire [Width-1:0] sum;
wire cout;
integer i;

ripple_carry_adder #(.Width(Width)) dut(.in0(in0), .in1(in1), .cin(cin), .sum(sum), .cout(cout));

initial begin
  for(i= 0; i< 2** (2* Width+ 1); i+= 1) begin
    {in0, in1, cin}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_ripple_carry_adder);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IN0|IN1|Cin|SUM|Cout|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, in0, in1, cin, sum, cout);
end
endmodule
