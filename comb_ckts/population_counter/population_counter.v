// Design Module

module population_counter #(
  parameter Width= 1
)(
  input [Width-1:0] in,
  output reg [$clog2(Width):0] out
);
  integer i;
  always @(*) begin
    out= 'b0;
    for(i= 0; i< Width; i+= 1) begin
      if(in[i])
        out+= 1;
    end
  end
endmodule

// Testbench Module

`timescale 1ns/1ns
module tb_population_counter;
localparam Width= 2;
reg [Width-1:0] in;
wire [$clog2(Width):0] out;
integer i;
population_counter #(
  .Width(Width)
) dut(
  .in(in),
  .out(out)
);
initial begin
  for(i= 0; i< 2** Width; i+= 1) begin
    in= i; #10;
  end
  $finish;
end
initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_population_counter);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IN|OUT|");
  $display("|-|-|-|");
  $monitor("|%0t|%b|%b|", $time, in, out);
end
endmodule
