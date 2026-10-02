// Design Module

module parity_code #(
  parameter Width= 2
)(
  input [Width-1:0] in,
  output [Width:0] out_even_parity_code, out_odd_parity_code,
  output out_even_parity_error, out_odd_parity_error
);
  even_parity_generator #(.Width(Width)) u_even_parity_generator(.in(in), .out(out_even_parity_code));
  odd_parity_generator #(.Width(Width)) u_odd_parity_generator(.in(in), .out(out_odd_parity_code));
  even_parity_checker #(.Width(Width)) u_even_parity_checker(.in(out_even_parity_code), .out_error(out_even_parity_error));
  odd_parity_checker #(.Width(Width)) u_odd_parity_checker(.in(out_odd_parity_code), .out_error(out_odd_parity_error));
endmodule

module even_parity_generator #(
  parameter Width= 2
)(
  input [Width-1:0] in,
  output [Width:0] out
);
  wire parity_bit;
  assign parity_bit= ^in;
  assign out= {parity_bit, in};
endmodule

module odd_parity_generator #(
  parameter Width= 2
)(
  input [Width-1:0] in,
  output [Width:0] out
);
  wire parity_bit;
  assign parity_bit= ~^in;
  assign out= {parity_bit, in};
endmodule

module even_parity_checker #(
  parameter Width= 2
)(
  input [Width:0] in,
  output out_error
);
  assign out_error= ^in;
endmodule

module odd_parity_checker #(
  parameter Width= 2
)(
  input [Width:0] in,
  output out_error
);
  assign out_error= ~^in;
endmodule

// Testbench Module

`timescale 1ns/1ns
module tb_parity_code;
  localparam Width= 4;
  reg [Width-1:0] in;
  wire [Width:0] out_even_parity_code, out_odd_parity_code;
  wire out_even_parity_error, out_odd_parity_error;
  integer i;
  parity_code #(
    .Width(Width)
  ) dut(
    .in(in),
    .out_even_parity_code(out_even_parity_code), .out_odd_parity_code(out_odd_parity_code),
    .out_even_parity_error(out_even_parity_error), .out_odd_parity_error(out_odd_parity_error)
  );
  initial begin
    for(i= 0; i< 2** Width; i+= 1) begin
      in= i; #10;
    end
    $finish;
  end
  initial begin
    $dumpfile(".vcd");
    $dumpvars(0, tb_parity_code);
    $display("Bit Width= %0d", Width);
    $display("|TIME|IN|EVEN_PARITY_CODE|ODD_PARITY_CODE|EVEN_PARITY_ERROR|ODD_PARITY_ERROR|");
    $display("|-|-|-|-|-|-|");
    $monitor("|%0t|%b|%b|%b|%b|%b|", $time, in, out_even_parity_code, out_odd_parity_code, out_even_parity_error, out_odd_parity_error);
  end
endmodule
