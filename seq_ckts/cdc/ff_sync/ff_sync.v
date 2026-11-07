// Design Module

module ff_sync #(
  parameter Flop_Count= 2
)(
  input clk, rst,
  input in,
  output out
);
  integer i;
  reg [Flop_Count-1:0] sync;
  assign out= sync[Flop_Count-1];
  always @(posedge clk or posedge rst) begin
    if(rst)
      sync<= 1'b0;
    else begin
      for(i= 0; i< Flop_Count; i+= 1) begin
        if(i== 0)
          sync[i]<= in;
        else
          sync[i]<= sync[i-1];
      end
    end
  end
endmodule

// Testbench Module

`timescale 1ns/1ns
module tb_ff_sync;
  localparam Flop_Count= 2;
  reg clk, rst;
  reg in;
  wire out;
  integer i;
  ff_sync #(
    .Flop_Count(Flop_Count)
  ) dut(
    .clk(clk), .rst(rst),
    .in(in),
    .out(out)
  );
  always #5 clk= ~clk;
  initial begin
    clk= 1'b0; rst= 1'b1; #10;
    rst= 1'b0; #10;
    repeat (10) begin
      in= $random; #10;
    end
    $finish;
  end
  initial begin
    $dumpfile(".vcd");
    $dumpvars(0, tb_ff_sync);
    $display("Flop Count= %0d", Flop_Count);
    $display("|CLK|RST|IN|OUT|");
    $display("|-|-|-|-|");
    $monitor("|%b|%b|%b|%b|", clk, rst, in, out);
  end
endmodule
