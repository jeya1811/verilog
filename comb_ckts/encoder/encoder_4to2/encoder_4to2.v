// Design Module

module encoder_4to2(
  input [3:0] ip,
  output reg [1:0] op
);
always @(*) begin
  case(ip)
    4'b0001: op= 2'b00;
    4'b0010: op= 2'b01;
    4'b0100: op= 2'b10;
    4'b1000: op= 2'b11;
    default: op= 'bx;
  endcase
end
endmodule

// Testbench Module

module tb_encoder_4to2;
reg [3:0] ip;
wire [1:0] op;
integer i;

encoder_4to2 dut(.ip(ip), .op(op));

initial begin
  for(i= 0; i< 2** 4; i+= 1) begin
    ip= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_encoder_4to2);
  $display("|TIME|IP|OP|");
  $display("|-|-|-|");
  $monitor("|%0t|%b|%b|", $time, ip, op);
end
endmodule
