// Design Module

module piso_left_shift_reg #(parameter Width= 2)(
  input clk, rst, load,
  input [Width-1:0] in,
  output out
);
wire [Width-1:0] tout;
genvar i;
generate
  for(i= 0; i< Width; i= i+ 1) begin: piso_left
    if(i== 0)
      d_ff u(.clk(clk), .rst(rst), .d(load? in[i]: 1'b0), .q(tout[i]));
    else
      d_ff u(.clk(clk), .rst(rst), .d(load? in[i]: tout[i-1]), .q(tout[i]));
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

module tb_piso_left_shift_reg;
localparam Width= 4;
reg clk= 1'b0;
reg rst= 1'b1;
reg load;
reg [Width-1:0] in;
wire out;
integer i, j;

piso_left_shift_reg #(.Width(Width)) dut(.clk(clk), .rst(rst), .load(load), .in(in), .out(out));

always #5  clk= ~clk;

initial begin
  #10; rst= 1'b0;
  for(i= 0; i< 2** Width; i+= 1) begin
    load= 1'b1; in= i; #10;
    load= 1'b0;
    for(j= 0; j< Width-1; j+= 1)
      #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_piso_left_shift_reg);
  $display("FlipFlop Count= %0d", Width);
  $display("|TIME|CLK|RST|LOAD|IN|OUT|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, clk, rst, load, in, out);
end
endmodule
