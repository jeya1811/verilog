// Design Module

module sipo_right_shift_reg #(parameter Width= 2)(
  input clk, rst, in,
  output [Width-1:0] out
);
genvar i;
generate
  for(i= 0; i< Width; i= i+ 1) begin: sipo_right
    if(i== Width-1)
      d_ff u(.clk(clk), .rst(rst), .d(in), .q(out[i]));
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

module tb_sipo_right_shift_reg;
localparam Width= 4;
reg clk= 1'b0;
reg rst= 1'b1;
reg [7:0] in_seq= 8'b01001011;
reg in;
wire [Width-1:0] out;
integer i;

sipo_right_shift_reg #(.Width(Width)) dut(.clk(clk), .rst(rst), .in(in), .out(out));

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
  $dumpvars(0, tb_sipo_right_shift_reg);
  $display("FlipFlop Count= %0d", Width);
  $display("|TIME|CLK|RST|IN|OUT|");
  $display("|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|", $time, clk, rst, in, out);
end
endmodule
