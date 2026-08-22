// Design Module

module pipo_reg #(parameter Width= 2)(
  input clk, rst,
  input [Width-1:0] in,
  output [Width-1:0] out
);
genvar i;
generate
  for(i= 0; i< Width; i= i+ 1) begin: pipo
    d_ff u(.clk(clk), .rst(rst), .d(in[i]), .q(out[i]));
  end
endgenerate
endmodule

module d_ff(
  input clk, rst, d,
  output reg q
);
always @(posedge clk or posedge rst) begin
  if(rst)
    q<= 1'b0;
  else
    q<= d;
end
endmodule

// Testbench Module

module tb_pipo_reg;
localparam Width= 4;
reg clk= 1'b0;
reg rst= 1'b1;
reg [Width-1:0] in;
wire [Width-1:0] out;
integer i;

pipo_reg #(.Width(Width)) dut(.clk(clk), .rst(rst), .in(in), .out(out));

always #5 clk= ~clk;

initial begin
  #10; rst= 1'b0;
  for(i= 0; i< 2** Width; i+= 1) begin
    in= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_pipo_reg);
  $display("FlipFlop Count= %0d", Width);
  $display("|TIME|CLK|RST|IN|OUT|");
  $display("|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|", $time, clk, rst, in, out);
end
endmodule
