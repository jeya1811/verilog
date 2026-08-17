// Design Module

module jk_ff(
  input clk, rst, j, k,
  output reg q,
  output q_n
);
assign q_n= ~q;
always @(posedge clk or posedge rst) begin
  if(rst)
    q<= 1'b0;
  else begin
    case({j, k})
      2'b00: q<= q;
      2'b01: q<= 1'b0;
      2'b10: q<= 1'b1;
      2'b11: q<= ~q;
    endcase
  end
end
endmodule

// Testbench Module

module tb_jk_ff;
reg clk= 1'b0;
reg rst= 1'b1;
reg j, k;
wire q, q_n;
integer i;

jk_ff dut(.clk(clk), .rst(rst), .j(j), .k(k), .q(q), .q_n(q_n));

always #5 clk= ~clk;

initial begin
  #10; rst= 1'b0;
  for(i= 0; i< 2** 2; i+= 1) begin
    {j, k}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_jk_ff);
  $display("|TIME|CLK|RST|J|K|Q|Qn|");
  $display("|-|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|%b|", $time, clk, rst, j, k, q, q_n);
end
endmodule
