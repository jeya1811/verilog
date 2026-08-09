// Design Module

module decoder_2to4(
  input [1:0] ip,
  output reg [3:0] op
);
always @(*) begin
  op= 'b1<< ip;
end
endmodule

// Testbench Module

module tb_decoder_2to4;
reg [1:0] ip;
wire [3:0] op;
integer i;

decoder_2to4 dut(.ip(ip), .op(op));

initial begin
  for(i= 0; i< 2** 2; i+= 1) begin
    ip= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_decoder_2to4);
  $display("|TIME|IP|OP|");
  $display("|-|-|-|");
  $monitor("|%0t|%b|%b|", $time, ip, op);
end
endmodule
