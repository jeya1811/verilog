// Design Module

module d_latch(
  input en, rst, d,
  output reg q,
  output q_n
);
assign q_n= ~q;
always @(*) begin
  if(rst)
    q<= 1'b0;
  else if(en) begin
    case(d)
      1'b0: q<= 1'b0;
      1'b1: q<= 1'b1;
    endcase
  end
end
endmodule

// Testbench Module

module tb_d_latch;
reg en, rst, d;
wire q, q_n;
integer i;

d_latch dut(.en(en), .rst(rst), .d(d), .q(q), .q_n(q_n));

initial begin
  rst= 1'b1; #10;
  rst= 1'b0;
  for(i= 0; i< 2** 2; i+= 1) begin
    {en, d}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_d_latch);
  $display("|TIME|EN|RST|D|Q|Qn|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, en, rst, d, q, q_n);
end
endmodule
