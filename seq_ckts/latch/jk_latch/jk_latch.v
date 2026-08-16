// Design Module

module jk_latch(
  input en, j, k,
  output reg q,
  output q_n
);
initial q= 0;
assign q_n= ~q;
always @(*) begin
  if(en) begin
    case({j, k})
      2'b00: q= q;
      2'b01: q= 'b0;
      2'b10: q= 'b1;
      2'b11: q= ~q;
    endcase
  end
end
endmodule

// Testbench Module

module tb_jk_latch;
reg en, j, k;
wire q, q_n;
integer i;

jk_latch dut(.en(en), .j(j), .k(k), .q(q), .q_n(q_n));

initial begin
  for(i= 0; i< 2** 3; i+= 1) begin
    {en, j, k}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_jk_latch);
  $display("|TIME|EN|J|K|Q|Qn|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, en, j, k, q, q_n);
end
endmodule
