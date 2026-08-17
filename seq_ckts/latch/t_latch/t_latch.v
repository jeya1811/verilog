// Design Module

module t_latch(
  input en, rst, t,
  output reg q,
  output q_n
);
assign q_n= ~q;
always @(*) begin
  if(rst)
    q<= 1'b0;
  else if(en) begin
    case(t)
      1'b0: q<= q;
      1'b1: q<= ~q;
    endcase
  end
end
endmodule

// Testbench Module

module tb_t_latch;
reg en, rst, t;
wire q, q_n;
integer i;

t_latch dut(.en(en), .rst(rst), .t(t), .q(q), .q_n(q_n));
initial begin
  rst= 1'b1; #10;
  rst= 1'b0;
  for(i= 0; i< 2** 2; i+= 1) begin
    {en, t}= i; #10;
  end
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_t_latch);
  $display("|TIME|EN|RST|T|Q|Qn|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, en, rst, t, q, q_n);
end
endmodule
