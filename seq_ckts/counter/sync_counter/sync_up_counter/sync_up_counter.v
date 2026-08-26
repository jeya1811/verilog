// Design Module

module sync_up_counter #(parameter Width= 2)(
  input clk, rst,
  output [Width-1:0] out
);
genvar i;
generate
  for(i= 0; i< Width; i= i+ 1) begin: sync_up
    if(i== 0)
      t_ff u(.clk(clk), .rst(rst), .t(1'b1), .q(out[i]));
    else begin
      t_ff u(.clk(clk), .rst(rst), .t(&(out[i-1:0])), .q(out[i]));
    end
  end
endgenerate
endmodule

module t_ff(
  input clk, rst, t,
  output reg q
);
always @(posedge clk or posedge rst) begin
  if(rst)
    q<= 1'b0;
  else begin
    case(t)
      1'b0: q<= q;
      1'b1: q<= ~q;
    endcase
  end
end
endmodule

// Testbench Module

module tb_sync_up_counter;
localparam Width= 4;
reg clk= 1'b0;
reg rst= 1'b1;
wire [Width-1:0] out;
integer i;

sync_up_counter #(.Width(Width)) dut(.clk(clk), .rst(rst), .out(out));

always #5 clk= ~clk;

initial begin
  #10; rst= 1'b0;
  for(i=0; i< 2** Width; i+= 1)
    #10;
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_sync_up_counter);
  $display("Counter Mod= %0d", 2** Width);
  $display("|TIME|CLK|RST|OUT|");
  $display("|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|", $time, clk, rst, out);
end
endmodule
