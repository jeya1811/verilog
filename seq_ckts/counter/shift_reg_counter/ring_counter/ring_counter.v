// Design Module

module ring_counter #(parameter Width= 2)(
  input clk, rst,
  output [Width-1:0] out
);
genvar i;
generate
  for(i= 0; i< Width; i= i+ 1) begin: ring
    if(Width== 1)
      d_ff u(.clk(clk), .rst(1'b0), .prst(rst), .d(out[0]), .q(out[0]));
    else begin
      if(i== Width-1)
        d_ff u(.clk(clk), .rst(1'b0), .prst(rst), .d(out[0]), .q(out[i]));
      else
        d_ff u(.clk(clk), .rst(rst), .prst(1'b0), .d(out[i+1]), .q(out[i]));
    end
  end
endgenerate
endmodule

module d_ff(
  input clk, rst, prst, d,
  output reg q
);
always @(posedge clk or posedge rst or posedge prst) begin
  if(rst)
    q<= 1'b0;
  else if(prst)
    q<= 1'b1;
  else
    q<= d;
end
endmodule

// Testbench Module

module tb_ring_counter;
localparam Width= 4;
reg clk= 1'b0;
reg rst= 1'b1;
wire [Width-1:0] out;
integer i;

ring_counter #(.Width(Width)) dut(.clk(clk), .rst(rst), .out(out));

always #5 clk= ~clk;

initial begin
  #10; rst= 1'b0;
  for(i= 0; i< Width; i+= 1)
    #10;
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_ring_counter);
  $display("Counter Mod= %0d", Width);
  $display("|TIME|CLK|RST|OUT|");
  $display("|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|", $time, clk, rst, out);
end
endmodule
