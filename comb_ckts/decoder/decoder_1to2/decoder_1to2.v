// Design Module

module decoder_1to2(
  input in,
  output reg [1:0] out
);
always @(*) begin
  out= 'b0;
  out[in]= 'b1;
end
endmodule

// Testbench Module

module tb_decoder_1to2;
reg in;
wire [1:0] out;
integer i;

decoder_1to2 dut(.in(in), .out(out));

initial begin
  for(i= 0; i< 2** 1; i+= 1) begin
    in= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_decoder_1to2);
  $display("|TIME|IN|OUT|");
  $display("|-|-|-|");
  $monitor("|%0t|%b|%b|", $time, in, out);
end
endmodule
