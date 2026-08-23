// Design Module

module universal_shift_reg #(parameter Width= 2)(
  input clk, rst, load, dir, serial_in,
  input [Width-1:0] parallel_in,
  output serial_out,
  output [Width-1:0] parallel_out
);
wire [Width-1:0] tout;
genvar i;
generate
  for(i= 0; i< Width; i= i+ 1) begin: universal
    if(Width== 1)
      d_ff u(.clk(clk), .rst(rst), .d(load? parallel_in[i]: serial_in), .q(tout[i]));
    else begin
      if(i== 0)
        d_ff u(.clk(clk), .rst(rst), .d(load? parallel_in[i]: dir? tout[i+1]: serial_in), .q(tout[i]));
      else if(i== Width-1)
        d_ff u(.clk(clk), .rst(rst), .d(load? parallel_in[i]: dir? serial_in: tout[i-1]), .q(tout[i]));
      else
        d_ff u(.clk(clk), .rst(rst), .d(load? parallel_in[i]: dir? tout[i+1]: tout[i-1]), .q(tout[i]));
    end
  end
endgenerate
assign serial_out= dir? tout[0]: tout[Width-1];
assign parallel_out= tout;
endmodule

module d_ff(
  input clk, rst, d,
  output reg q
);
always @(posedge clk or posedge rst) begin
  if(rst)
    q<= 1'b0;
  else
    q<= d;
end
endmodule

// Testbench Module

module tb_universal_shift_reg;
localparam Width= 4;
reg clk= 1'b0;
reg rst= 1'b1;
reg [7:0] in_seq= 8'b01011001;
reg load, dir, serial_in;
reg [Width-1:0] parallel_in;
wire serial_out;
wire [Width-1:0] parallel_out;
integer i, j;

universal_shift_reg #(.Width(Width)) dut(.clk(clk), .rst(rst), .load(load), .dir(dir), .serial_in(serial_in), .parallel_in(parallel_in), .serial_out(serial_out), .parallel_out(parallel_out));

always #5 clk= ~clk;

initial begin
  #10; rst= 1'b0;
  for(i= 0; i< 2** Width; i+= 1) begin
    load= 1'b1; dir= 1'b1; parallel_in= i; serial_in= in_seq[i% 8]; #10;
    load= 1'b0;
    for(j= 0; j< Width-1; j+= 1)
      #10;
    load= 1'b1; dir= 1'b0; parallel_in= i; serial_in= in_seq[i% 8]; #10;
    load= 1'b0;
    for(j= 0; j< Width-1; j+= 1)
      #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_universal_shift_reg);
  $display("FlipFlop Count= %0d", Width);
  $display("|TIME|CLK|RST|LOAD|DIR|SERIAL_IN|PARALLEL_IN|SERIAL_OUT|PARALLEL_OUT|");
  $display("|-|-|-|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|%b|%b|%b|", $time, clk, rst, load, dir, serial_in, parallel_in, serial_out, parallel_out);
end
endmodule
