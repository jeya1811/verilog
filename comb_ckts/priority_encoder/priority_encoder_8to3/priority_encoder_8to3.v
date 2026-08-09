// Design Module

module priority_encoder_8to3(
  input [7:0] ip,
  output reg [2:0] op
);
always @(*) begin
  casez(ip)
    8'b1???????: op= 3'b111;
    8'b01??????: op= 3'b110;
    8'b001?????: op= 3'b101;
    8'b0001????: op= 3'b100;
    8'b00001???: op= 3'b011;
    8'b000001??: op= 3'b010;
    8'b0000001?: op= 3'b001;
    8'b00000001: op= 3'b000;
    default: op= 'bx;
  endcase
end
endmodule

// Testbench Module

module tb_priority_encoder_8to3;
reg [7:0] ip;
wire [2:0] op;
integer i;

priority_encoder_8to3 dut(.ip(ip), .op(op));

initial begin
  for(i= 0; i< 2** 8; i+= 1) begin
    ip= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_priority_encoder_8to3);
  $display("|TIME|IP|OP|");
  $display("|-|-|-|");
  $monitor("|%0t|%b|%b|", $time, ip, op);
end
endmodule
