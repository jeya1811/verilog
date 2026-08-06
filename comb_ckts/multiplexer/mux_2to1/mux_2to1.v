// Design Module

module mux_2to1 #(parameter Width= 1)(
  input [Width-1:0] i0, i1,
  input sel,
  output [Width-1:0] y
);
assign y= sel? i1: i0;
endmodule

// Testbench Module

module tb;
localparam Width= 1;
reg [Width-1:0] i0, i1;
reg sel;
wire [Width-1:0] y;
integer i;

mux_2to1 #(.Width(Width)) dut(.i0(i0), .i1(i1), .sel(sel), .y(y));

initial begin
  for(i= 0; i< 2** (2* Width+ 1); i+= 1) begin
    {i0, i1, sel}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb);
  $display("Bit Width= %0d", Width);
  $display("|TIME|I0|I1|SEL|Y|");
  $display("|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|", $time, i0, i1, sel, y);
end
endmodule
