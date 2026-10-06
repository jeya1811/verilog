// Design Module

module parity_code #(
  parameter Width= 2,
  parameter Parity= 0
)(
  input [Width-1:0] in_data,
  output [Width:0] out_code,
  output [Width-1:0] out_data,
  output out_error
);
  parity_encoder #(
    .Width(Width),
    .Parity(Parity)
  ) u_parity_encoder(
    .in_data(in_data),
    .out_code(out_code)
  );
  parity_decoder #(
    .Width(Width),
    .Parity(Parity)
  ) u_parity_decoder(
    .in_code(out_code),
    .out_data(out_data),
    .out_error(out_error)
  );
endmodule

module parity_encoder #(
  parameter Width= 2,
  parameter Parity= 0
)(
  input [Width-1:0] in_data,
  output [Width:0] out_code
);
  wire parity;
  assign parity=Parity^ (^in_data);
  assign out_code= {parity, in_data};
endmodule

module parity_decoder #(
  parameter Width= 2,
  parameter Parity= 0
)(
  input [Width:0] in_code,
  output [Width-1:0] out_data,
  output out_error
);
  assign out_error= Parity^ (^in_code);
  assign out_data= (!out_error)? in_code[Width-1:0]: 'bx;
endmodule

// Testbench Module

`timescale 1ns/1ns
module tb_parity_code;
  localparam Width= 4;
  localparam Parity= 1;
  reg [Width-1:0] in_data;
  wire [Width:0] out_code;
  wire [Width-1:0] out_data;
  wire out_error;
  integer i;
  parity_code #(
    .Width(Width),
    .Parity(Parity)
  ) dut(
    .in_data(in_data),
    .out_code(out_code),
    .out_data(out_data),
    .out_error(out_error)
  );
  initial begin
    for(i= 0; i< 2** Width; i+= 1) begin
      in_data= i; #10;
    end
    $finish;
  end
  initial begin
    $dumpfile(".vcd");
    $dumpvars(0, tb_parity_code);
    $display("Bit Width= %0d and Parity= %0s", Width, Parity? "odd": "even");
    $display("|TIME|IN_DATA|OUT_CODE|OUT_DATA|OUT_ERROR|");
    $display("|-|-|-|-|-|");
    $monitor("|%0t|%b|%b|%b|%b|", $time, in_data, out_code, out_data, out_error);
  end
endmodule
