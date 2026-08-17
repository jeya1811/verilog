// Design Module

module sr_latch(
  input en, rst, s, r,
  output reg q,
  output q_n
);
assign q_n= ~q;
always @(*) begin
  if(rst)
    q<= 1'b0;
  else if(en) begin
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

module tb_sr_latch;
reg en, rst, s, r;
wire q, q_n;
integer i;

sr_latch dut(.s(s), .rst(rst), .r(r), .en(en), .q(q), .q_n(q_n));

initial begin
  rst= 1'b1; #10;
  rst= 1'b0;
  for(i= 0; i< 2** 3; i+= 1) begin
    {en, s, r}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_sr_latch);
  $display("|TIME|EN|RST|S|R|Q|Qn|");
  $display("|-|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|%b|", $time, en, rst, s, r, q, q_n);
end
endmodule
