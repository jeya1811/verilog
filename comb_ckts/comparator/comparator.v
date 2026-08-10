// Design Module

module comparator #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  output out_gt, out_eq, out_lt
);
assign out_gt= in0> in1;
assign out_eq= in0== in1;
assign out_lt= in0< in1;
endmodule

// Testbench Module

module tb_comparator;
localparam Width= 2;
reg [Width-1:0] in0, in1;
wire out_gt, out_eq, out_lt;
integer i;

comparator #(.Width(Width)) dut(.in0(in0), .in1(in1), .out_gt(out_gt), .out_eq(out_eq), .out_lt(out_lt));

initial begin
  for(i= 0; i< 2** (2* Width); i+= 1) begin
    {in0, in1}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_comparator);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IN1|IP2|GT|EQ|LT|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, in0, in1, out_gt, out_eq, out_lt);
end
endmodule
