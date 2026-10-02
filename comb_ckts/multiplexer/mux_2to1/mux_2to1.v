// Design Module

module mux_2to1 #(
  parameter Width= 1
)(
  input sel,
  input [Width-1:0] in0, in1,
  output [Width-1:0] out
);
  assign out= sel? in1: in0;
endmodule

// Testbench Module

`timescale 1ns/1ns
module tb_mux_2to1;
  localparam Width= 2;
  reg sel;
  reg [Width-1:0] in0, in1;
  wire [Width-1:0] out;
  integer i;
  mux_2to1 #(
    .Width(Width)
  ) dut(
    .sel(sel),
    .in0(in0), .in1(in1),
    .out(out)
  );
  initial begin
    for(i= 0; i< 2** (2* Width+ 1); i+= 1) begin
      {sel, in0, in1}= i; #10;
    end
    $finish;
  end
  initial begin
    $dumpfile(".vcd");
    $dumpvars(0, tb_mux_2to1);
    $display("Bit Width= %0d", Width);
    $display("|TIME|SEL|IN0|IN1|OUT|");
    $display("|-|-|-|-|-|");
    $monitor("|%0t|%b|%b|%b|%b|", $time, sel, in0, in1, out);
  end
endmodule
