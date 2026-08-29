// Design Module

module sync_up_down_counter #(parameter Width= 2)(
  input clk, rst, dir, 
  output [Width-1:0] out
);
genvar i;
generate
  for(i= 0; i< Width; i= i+ 1) begin: up_down
    if(i== 0)
      t_ff u(.clk(clk), .rst(rst), .t(1'b1), .q(out[i]));
    else
      t_ff u(.clk(clk), .rst(rst), .t(dir? &(~out[i-1:0]): &(out[i-1:0])), .q(out[i]));
  end
endgenerate
endmodule

module t_ff(
  input clk, rst, t,
  output reg q
);
always @(posedge clk or posedge rst) begin
  if(rst)
    q<= 1'b0;
  else
    case(t)
      1'b0: q<= q;
      1'b1: q<= ~q;
    endcase
end
endmodule

// Testbench Module

module tb_sync_up_down_counter;
localparam Width= 4;
reg clk= 1'b0;
reg rst= 1'b1;
reg dir;
wire [Width-1:0] out;
integer i;

sync_up_down_counter #(.Width(Width)) dut(.clk(clk), .rst(rst), .dir(dir), .out(out));

always #5 clk= ~clk;

initial begin
  #10; rst= 1'b0;
  dir= 1'b0;
  for(i= 0; i< 2** Width; i+= 1)
    #10;
  dir= 1'b1;
  for(i= 0; i< 2** Width; i+= 1)
    #10;
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_sync_up_down_counter);
  $display("Counter Mod= %0d", 2** Width);
  $display("|TIME|CLK|RST|DIR|OUT|");
  $display("|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|", $time, clk, rst, dir, out);
end
endmodule
