// Design Module

module decoder_1to2(
  input ip,
  output reg [1:0] op
);
always @(*) begin
  op= 'b0;
  op[ip]= 'b1;
end
endmodule

// Testbench Module

module tb_decoder_1to2;
reg ip;
wire [1:0] op;
integer i;

decoder_1to2 dut(.ip(ip), .op(op));

initial begin
  for(i= 0; i< 2** 1; i+= 1) begin
    ip= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_decoder_1to2);
  $display("|TIME|IP|OP|");
  $display("|-|-|-|");
  $monitor("|%0t|%b|%b|", $time, ip, op);
end
endmodule
