// Design Module

module d_ff(
  input clk, rst, d,
  output reg q,
  output q_n
);
assign q_n= ~q;
always @(posedge clk or posedge rst) begin
  if(rst)
    q<= 1'b0;
  else begin
    case(d)
      1'b0: q<= 1'b0;
      1'b1: q<= 1'b1;
    endcase
  end
end
endmodule

// Testbench Module

module tb_d_ff;
reg clk= 1'b0;
reg rst= 1'b1;
reg d;
wire q, q_n;
integer i;

d_ff dut(.clk(clk), .rst(rst), .d(d), .q(q), .q_n(q_n));

always #5 clk= ~clk;

initial begin
  #10; rst= 1'b0;
  for(i= 0; i< 2** 1; i+= 1) begin
    d= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_d_ff);
  $display("|TIME|CLK|RST|D|Q|Qn|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, clk, rst, d, q, q_n);
end
endmodule
