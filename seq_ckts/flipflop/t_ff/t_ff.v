// Design Module

module t_ff(
  input clk, rst, t,
  output reg q,
  output q_n
);
assign q_n= ~q;
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

module tb_t_ff;
reg clk= 1'b0;
reg rst= 1'b1;
reg t;
wire q, q_n;
integer i;

t_ff dut(.clk(clk), .rst(rst), .t(t), .q(q), .q_n(q_n));

always #5 clk= ~clk;

initial begin
  #10; rst= 1'b0;
  for(i= 0; i< 2** 1; i+= 1) begin
    t= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_t_ff);
  $display("|TIME|CLK|RST|T|Q|Qn|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, clk, rst, t, q, q_n);
end
endmodule
