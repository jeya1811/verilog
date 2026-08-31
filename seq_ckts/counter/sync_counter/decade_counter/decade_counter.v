// Design Module

module decade_counter(
  input clk, rst,
  output [3:0] out
);
wire mod_rst= (out== 4'b1010)|| rst;
genvar i;
generate
  for(i= 0; i< 4; i= i+ 1) begin: decade
    if(i== 0)
      t_ff u(.clk(clk), .rst(mod_rst), .t(1'b1), .q(out[i]));
    else
      t_ff u(.clk(clk), .rst(mod_rst), .t(&(out[i-1:0])), .q(out[i]));
  end
endgenerate
endmodule

module t_ff(
  input clk, rst, t,
  output reg q
);
always @(posedge clk or posedge rst) begin
  if(rst)
    q<= 0;
  else begin
    case(t)
      1'b0: q<= q;
      1'b1: q<= ~q;
    endcase
  end
end
endmodule

// Testbench Module

module tb_decade_counter;
reg clk= 1'b0;
reg rst= 1'b1;
wire [3:0] out;
integer i;

decade_counter dut(.clk(clk), .rst(rst), .out(out));

always #5 clk= ~clk;

initial begin
  #10; rst= 1'b0;
  for(i= 0; i< 10; i+= 1)
    #10;
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_decade_counter);
  $display("|TIME|CLK|RST|OUT|");
  $display("|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|", $time, clk, rst, out);
end
endmodule
