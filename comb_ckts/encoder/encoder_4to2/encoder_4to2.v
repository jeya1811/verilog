// Design Module

module encoder_4to2(
  input [3:0] in,
  output reg [1:0] out
);
always @(*) begin
  case(in)
    4'b0001: out= 2'b00;
    4'b0010: out= 2'b01;
    4'b0100: out= 2'b10;
    4'b1000: out= 2'b11;
    default: out= 'bx;
  endcase
end
endmodule

// Testbench Module

module tb_encoder_4to2;
reg [3:0] in;
wire [1:0] out;
integer i;

encoder_4to2 dut(.in(in), .out(out));

initial begin
  for(i= 0; i< 2** 4; i+= 1) begin
    in= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_encoder_4to2);
  $display("|TIME|IN|OUT|");
  $display("|-|-|-|");
  $monitor("|%0t|%b|%b|", $time, in, out);
end
endmodule
