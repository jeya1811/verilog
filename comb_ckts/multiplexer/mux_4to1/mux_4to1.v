// Design Module

module mux_4to1 #(
  parameter Width= 1
)(
  input [1:0] sel,
  input [Width-1:0] in0, in1, in2, in3,
  output reg [Width-1:0] out
);
  always @(*) begin
    case(sel)
      2'b00: out= in0;
      2'b01: out= in1;
      2'b10: out= in2;
      2'b11: out= in3;
      default: out= 'b0;
    endcase
  end
endmodule

// Testbench Module

`timescale 1ns/1ns
module tb_mux_4to1;
  localparam Width= 1;
  reg [1:0] sel;
  reg [Width-1:0] in0, in1, in2, in3;
  wire [Width-1:0] out;
  integer i;
  mux_4to1 #(
    .Width(Width)
  ) dut(
    .sel(sel),
    .in0(in0), .in1(in1), .in2(in2), .in3(in3),
    .out(out)
  );
  initial begin
    for(i= 0; i< 2** (4* Width+ 2); i+= 1) begin
      {sel, in0, in1, in2, in3}= i; #10;
    end
    $finish;
  end
  initial begin
    $dumpfile(".vcd");
    $dumpvars(0, tb_mux_4to1);
    $display("Bit Width= %0d", Width);
    $display("|TIME|SEL|IN0|IN1|IN2|IN3|OUT|");
    $display("|-|-|-|-|-|-|-|");
    $monitor("|%0t|%b|%b|%b|%b|%b|%b|", $time, sel, in0, in1, in2, in3, out);
  end
endmodule
