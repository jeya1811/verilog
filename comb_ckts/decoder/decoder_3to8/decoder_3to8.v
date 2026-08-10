// Design Module

module decoder_3to8(
  input [2:0] in,
  output reg [7:0] out
);
always @(*) begin
  out= 'b1<< in;
end
endmodule

// Testbench Module

module tb_decoder_3to8;
reg [2:0] in;
wire [7:0] out;
integer i;

decoder_3to8 dut(.in(in), .out(out));

initial begin
  for(i= 0; i< 2** 3; i+= 1) begin
    in= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_decoder_3to8);
  $display("|TIME|IN|OUT|");
  $display("|-|-|-|");
  $monitor("|%0t|%b|%b|", $time, in, out);
end
endmodule
