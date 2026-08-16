// Design Module

module t_latch(
  input en, t,
  output reg q,
  output q_n
);
initial q= 0;
assign q_n= ~q;
always @(*) begin
  if(en) begin
    case(t)
      1'b0: q= q;
      1'b1: q= ~q;
    endcase
  end
end
endmodule

// Testbench Module

module tb_t_latch;
reg en, t;
wire q, q_n;
integer i;

t_latch dut(.en(en), .t(t), .q(q), .q_n(q_n));
initial begin
  for(i= 0; i< 2** 2; i+= 1) begin
    {en, t}= i; #10;
  end
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_t_latch);
  $display("|TIME|EN|T|Q|Qn|");
  $display("|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|", $time, en, t, q, q_n);
end
endmodule
