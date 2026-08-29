// Design Module

module johnson_counter #(parameter Width= 2)(
  input clk, rst,
  output [Width-1:0] out
);
genvar i;
generate
  for(i= 0; i< Width; i= i+ 1) begin: johnson
    if(i== Width-1)
      d_ff u(.clk(clk), .rst(rst), .d(~out[0]), .q(out[i]));
    else
      d_ff u(.clk(clk), .rst(rst), .d(out[i+1]), .q(out[i]));
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

module tb_johnson_counter;
localparam Width= 4;
reg clk= 1'b0;
reg rst= 1'b1;
wire [Width-1:0] out;
integer i;

johnson_counter #(.Width(Width)) dut(.clk(clk), .rst(rst), .out(out));

always #5 clk= ~clk;

initial begin
  #10; rst= 1'b0;
  for(i= 0; i< 2* Width; i+= 1)
    #10;
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_johnson_counter);
  $display("Counter Mod= %0d", 2* Width);
  $display("|TIME|CLK|RST|OUT|");
  $display("|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|", $time, clk, rst, out);
end
endmodule
