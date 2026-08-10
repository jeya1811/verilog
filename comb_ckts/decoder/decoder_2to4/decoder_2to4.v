// Design Module

module decoder_2to4(
  input [1:0] in,
  output reg [3:0] out
);
always @(*) begin
  out= 'b1<< in;
end
endmodule

// Testbench Module

module tb_decoder_2to4;
reg [1:0] in;
wire [3:0] out;
integer i;

decoder_2to4 dut(.in(in), .out(out));

initial begin
  for(i= 0; i< 2** 2; i+= 1) begin
    in= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_decoder_2to4);
  $display("|TIME|IN|OUT|");
  $display("|-|-|-|");
  $monitor("|%0t|%b|%b|", $time, in, out);
end
endmodule
