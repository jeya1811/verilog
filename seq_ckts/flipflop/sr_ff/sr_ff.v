// Design Module

module sr_ff(
  input clk, rst, s, r,
  output reg q,
  output q_n
);
assign q_n= ~q;
always @(posedge clk or posedge rst) begin
  if(rst)
    q<= 1'b0;
  else begin
    case({s, r})
      2'b00: q<= q;
      2'b01: q<= 1'b0;
      2'b10: q<= 1'b1;
      2'b11: q<= 1'bx;
    endcase
  end
end
endmodule

// Testbench Module

module tb_sr_ff;
reg clk= 1'b0;
reg rst= 1'b1;
reg s, r;
wire q, q_n;
integer i;

sr_ff dut(.clk(clk), .rst(rst), .s(s), .r(r), .q(q), .q_n(q_n));

always #5 clk= ~clk;

initial begin
  #10; rst= 1'b0;
  for(i= 0; i< 2** 2; i+= 1) begin
    {s, r}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_sr_ff);
  $display("|TIME|CLK|RST|S|R|Q|Qn|");
  $display("|-|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|%b|", $time, clk, rst, s, r, q, q_n);
end
endmodule
