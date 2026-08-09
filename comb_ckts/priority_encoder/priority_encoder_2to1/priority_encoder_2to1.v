// Design Module

module priority_encoder_2to1(
  input [1:0] ip,
  output reg op
);
always @(*) begin
  casez(ip)
    2'b1?: op= 'b1;
    2'b01: op= 'b0;
    default: op= 'bx;
  endcase
end
endmodule

// Testbench Module

module tb_priority_encoder_2to1;
reg [1:0] ip;
wire op;
integer i;

priority_encoder_2to1 dut(.ip(ip), .op(op));

initial begin
  for(i= 0; i< 2** 2; i+= 1) begin
    ip= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_priority_encoder_2to1);
  $display("|TIME|IP|OP|");
  $display("|-|-|-|");
  $monitor("|%0t|%b|%b|", $time, ip, op);
end
endmodule
