// Design Module

module demux_1to8 #(
  parameter Width= 1
)(
  input [2:0] sel,
  input [Width-1:0] in,
  output reg [Width-1:0] out0, out1, out2, out3,
  output reg [Width-1:0] out4, out5, out6, out7
);
  always @(*) begin
    {out0, out1, out2, out3}= 'b0;
    {out4, out5, out6, out7}= 'b0;
    case(sel)
      3'b000: out0= in;
      3'b001: out1= in;
      3'b010: out2= in;
      3'b011: out3= in;
      3'b100: out4= in;
      3'b101: out5= in;
      3'b110: out6= in;
      3'b111: out7= in;
    endcase
  end
endmodule

// Testbench Module

`timescale 1ns/1ns
module tb_demux_1to8;
  localparam Width= 2;
  reg [2:0] sel;
  reg [Width-1:0] in;
  wire [Width-1:0] out0, out1, out2, out3;
  wire [Width-1:0] out4, out5, out6, out7;
  integer i;
  demux_1to8 #(
    .Width(Width)
  ) dut(
    .sel(sel),
    .in(in),
    .out0(out0), .out1(out1), .out2(out2), .out3(out3),
    .out4(out4), .out5(out5), .out6(out6), .out7(out7)
  );
  initial begin
    for(i= 0; i< 2** (Width+ 3); i+= 1) begin
      {sel, in}= i; #10;
    end
    $finish;
  end
  initial begin
    $dumpfile(".vcd");
    $dumpvars(0, tb_demux_1to8);
    $display("Bit Width= %0d", Width);
    $display("|TIME|SEL|IN|OUT0|OUT1|OUT2|OUT3|OUT4|OUT5|OUT6|OUT7|");
    $display("|-|-|-|-|-|-|-|-|-|-|-|");
    $monitor("|%0t|%b|%b|%b|%b|%b|%b|%b|%b|%b|%b|", $time, sel, in, out0, out1, out2, out3, out4, out5, out6, out7);
  end
endmodule
