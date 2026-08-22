// Design Module

module siso_reg #(parameter Width= 2)(
  input clk, rst, in,
  output out
);
wire [Width-1:0] tout;
genvar i;
generate
  for(i= 0; i< Width; i= i+ 1) begin: siso
    if(i== 0)
      d_ff u(.clk(clk), .rst(rst), .d(in), .q(tout[i]));
    else
      d_ff u(.clk(clk), .rst(rst), .d(tout[i-1]), .q(tout[i]));
  end
endgenerate
assign out= tout[Width-1];
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

module tb_siso_reg;
localparam Width= 4;
reg clk= 1'b0;
reg rst= 1'b1;
reg [7:0] in_seq= 8'b01011101;
reg in;
wire out;
integer i;

siso_reg #(.Width(Width)) dut(.clk(clk), .rst(rst), .in(in), .out(out));

always #5 clk= ~clk;

initial begin
  #10; rst= 1'b0;
  for(i= 0; i< 2** 3; i+= 1) begin
    in= in_seq[7-i]; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_siso_reg);
  $display("FlipFlop Count= %0d", Width);
  $display("|TIME|CLK|RST|IN|OUT|");
  $display("|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|", $time, clk, rst, in, out);
end
endmodule
