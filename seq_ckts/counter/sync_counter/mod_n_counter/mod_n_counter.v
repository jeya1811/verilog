// Design Module

module mod_n_counter #(parameter Mod= 2)(
  input clk, rst,
  output [($clog2(Mod))-1:0] out
);
wire mod_rst= (out== Mod)|| rst;
genvar i;
generate
  for(i= 0; i< $clog2(Mod); i= i+ 1) begin: mod_n
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
    q<= 1'b0;
  else begin
    case(t)
      1'b0: q<= q;
      1'b1: q<= ~q;
    endcase
  end
end
endmodule

// Testbench Module

module tb_mod_n_counter;
localparam Mod= 10;
reg clk= 1'b0;
reg rst= 1'b1;
wire [($clog2(Mod))-1:0] out;
integer i;

mod_n_counter #(.Mod(Mod)) dut(.clk(clk), .rst(rst), .out(out));

always #5 clk= ~clk;

initial begin
  #10; rst= 1'b0;
  for(i= 0; i< Mod; i+= 1)
    #10;
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_mod_n_counter);
  $display("Counter Mod= %0d", Mod);
  $display("|TIME|CLK|RST|OUT|");
  $display("|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|", $time, clk, rst, out);
end
endmodule
