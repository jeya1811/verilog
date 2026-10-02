// Design Module

module tristate_gate #(
  parameter Width= 1
)(
  input en,
  input [Width-1:0] in,
  output [Width-1:0] out_buf_if_0, out_buf_if_1,
  output [Width-1:0] out_not_if_0, out_not_if_1
);
  buf_if_0 #(
    .Width(Width)
  ) u_buf_if_0(
    .en(en),
    .in(in),
    .out(out_buf_if_0)
  );
  buf_if_1 #(
    .Width(Width)
  ) u_buf_if_1(
    .en(en),
    .in(in),
    .out(out_buf_if_1)
  );
  not_if_0 #(
    .Width(Width)
  ) u_not_if_0(
    .en(en),
    .in(in),
    .out(out_not_if_0)
  );
  not_if_1 #(
    .Width(Width)
  ) u_not_if_1(
    .en(en),
    .in(in),
    .out(out_not_if_1)
  );
endmodule

module buf_if_0 #(
  parameter Width= 1
)(
  input en,
  input [Width-1:0] in,
  output [Width-1:0] out
);
  assign out= en? 'bz: in;
endmodule

module buf_if_1 #(
  parameter Width= 1
)(
  input en,
  input [Width-1:0] in,
  output [Width-1:0] out
);
  assign out= en? in: 'bz;
endmodule

module not_if_0 #(
  parameter Width= 1
)(
  input en,
  input [Width-1:0] in,
  output [Width-1:0] out
);
  assign out= en? 'bz: ~in;
endmodule

module not_if_1 #(
  parameter Width= 1
)(
  input en,
  input [Width-1:0] in,
  output [Width-1:0] out
);
  assign out= en? ~in: 'bz;
endmodule

// Testbench Module

`timescale 1ns/1ns
module tb_tristate_gate;
  localparam Width= 2;
  reg en;
  reg [Width-1:0] in;
  wire [Width-1:0] out_buf_if_0, out_buf_if_1;
  wire [Width-1:0] out_not_if_0, out_not_if_1;
  integer i;
  tristate_gate #(
    .Width(Width)
  ) dut(
    .en(en),
    .in(in),
    .out_buf_if_0(out_buf_if_0), .out_buf_if_1(out_buf_if_1),
    .out_not_if_0(out_not_if_0), .out_not_if_1(out_not_if_1)
  );
  initial begin
    for(i= 0; i< 2** (Width+ 1); i+= 1) begin
      {en, in}= i; #10;
    end
    $finish;
  end
  initial begin
    $dumpfile(".vcd");
    $dumpvars(0, tb_tristate_gate);
    $display("Bit Width= %0d", Width);
    $display("|TIME|EN|IN|BUF_IF_0|BUF_IF_1|NOT_IF_0|NOT_IF_1|");
    $display("|-|-|-|-|-|-|-|");
    $monitor("|%0t|%b|%b|%b|%b|%b|%b|", $time, en, in, out_buf_if_0, out_buf_if_1, out_not_if_0, out_not_if_1);
  end
endmodule
