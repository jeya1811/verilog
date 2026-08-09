// Design Module

module decoder_3to8(
  input [2:0] ip,
  output reg [7:0] op
);
always @(*) begin
  op= 'b1<< ip;
end
endmodule

// Testbench Module

module tb_decoder_3to8;
reg [2:0] ip;
wire [7:0] op;
integer i;

decoder_3to8 dut(.ip(ip), .op(op));

initial begin
  for(i= 0; i< 2** 3; i+= 1) begin
    ip= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_decoder_3to8);
  $display("|TIME|IP|OP|");
  $display("|-|-|-|");
  $monitor("|%0t|%b|%b|", $time, ip, op);
end
endmodule
