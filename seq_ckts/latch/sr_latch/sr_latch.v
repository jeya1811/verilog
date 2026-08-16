// Design Module

module sr_latch(
  input en, s, r,
  output reg q,
  output q_n
);
initial q= 0;
assign q_n= ~q;
always @(*) begin
  if(en) begin
    case({s, r})
      2'b00: q= q;
      2'b01: q= 0;
      2'b10: q= 1;
      2'b11: q= 'bx;
    endcase
  end
end
endmodule

// Testbench Module

module tb_sr_latch;
reg en, s, r;
wire q, q_n;
integer i;

sr_latch dut(.s(s), .r(r), .en(en), .q(q), .q_n(q_n));

initial begin
  for(i= 0; i< 2** 3; i+= 1) begin
    {en, s, r}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_sr_latch);
  $display("|TIME|EN|S|R|Q|Qn|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, en, s, r, q, q_n);
end
endmodule
