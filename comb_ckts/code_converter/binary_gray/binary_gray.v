// Design Module

module binary_gray #(parameter Width= 2)(
  input [Width-1:0] in,
  output [Width-1:0] out_gray, out_binary
);
binary_to_gray #(.Width(Width)) u0(.in(in), .out(out_gray));
gray_to_bin #(.Width(Width)) u1(.in(out_gray), .out(out_binary));
endmodule

module binary_to_gray #(parameter Width= 2)(
  input [Width-1:0] in,
  output [Width-1:0] out
);
genvar i;
generate
  for(i= 0; i< Width; i= i+ 1) begin: bin_2_gray
    if(i== Width-1)
      assign out[i]= in[i];
    else
      assign out[i]= in[i]^ in[i+1];
  end
endgenerate
endmodule

module gray_to_bin #(parameter Width= 2)(
  input [Width-1:0] in,
  output [Width-1:0] out
);
genvar i;
generate
  for(i= 0; i< Width; i= i+ 1) begin: gray_2_bin
    if(i== Width-1)
      assign out[i]= in[i];
    else
      assign out[i]= in[i]^ out[i+1];
  end
endgenerate
endmodule

// Testbench Module

`timescale 1ns/1ns
module tb_binary_gray;
localparam Width= 4;
reg [Width-1:0] in;
wire [Width-1:0] out_gray, out_binary;
integer i;

binary_gray #(.Width(Width)) dut(.in(in), .out_gray(out_gray), .out_binary(out_binary));

initial begin
  for(i= 0; i< 2** Width; i+= 1) begin
    in= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_binary_gray);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IN|OUT_GRAY|OUT_BINARY|");
  $display("|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|", $time, in, out_gray, out_binary);
end
endmodule
