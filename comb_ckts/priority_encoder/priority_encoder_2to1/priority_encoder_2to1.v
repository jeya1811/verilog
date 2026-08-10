// Design Module

module priority_encoder_2to1(
  input [1:0] in,
  output reg out
);
always @(*) begin
  casez(in)
    2'b1?: out= 'b1;
    2'b01: out= 'b0;
    default: out= 'bx;
  endcase
end
endmodule

// Testbench Module

module tb_priority_encoder_2to1;
reg [1:0] in;
wire out;
integer i;

priority_encoder_2to1 dut(.in(in), .out(out));

initial begin
  for(i= 0; i< 2** 2; i+= 1) begin
    in= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_priority_encoder_2to1);
  $display("|TIME|IN|OUT|");
  $display("|-|-|-|");
  $monitor("|%0t|%b|%b|", $time, in, out);
end
endmodule
