// Design Module

module jk_latch(
  input en, rst, j, k,
  output reg q,
  output q_n
);
assign q_n= ~q;
always @(*) begin
  if(rst)
    q<= 1'b0;
  else if(en) begin
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

module tb_jk_latch;
reg en, rst, j, k;
wire q, q_n;
integer i;

jk_latch dut(.en(en), .rst(rst), .j(j), .k(k), .q(q), .q_n(q_n));

initial begin
  rst= 1'b1; #10;
  rst= 1'b0;
  for(i= 0; i< 2** 3; i+= 1) begin
    {en, j, k}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_jk_latch);
  $display("|TIME|EN|RST|J|K|Q|Qn|");
  $display("|-|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|%b|", $time, en, rst, j, k, q, q_n);
end
endmodule
