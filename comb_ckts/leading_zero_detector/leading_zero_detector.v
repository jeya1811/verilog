// Design Module

module leading_zero_detector #(
  parameter Width= 1
)(
  input [Width-1:0] in,
  output reg [$clog2(Width):0] out
);
  integer i;
  always @(*) begin
    out= 'b0;
    i= 0;
    while((i< Width)&& (!in[Width-1-i])) begin
      out+= 1;
      i+= 1;
    end
  end
endmodule

// Testbench Module

`timescale 1ns/1ns
module tb_leading_zero_detector;
localparam Width= 4;
reg [Width-1:0] in;
wire [$clog2(Width):0] out;
integer i;
leading_zero_detector #(
  .Width(Width)
) dut(
  .in(in),
  .out(out)
);
initial begin
  for(i= 0; i< 2** Width; i+= 1) begin
    in= i; #10;
  end
  $finish;
end
initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_leading_zero_detector);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IN|OUT|");
  $display("|-|-|-|");
  $monitor("|%0t|%b|%b|", $time, in, out);
end
endmodule
