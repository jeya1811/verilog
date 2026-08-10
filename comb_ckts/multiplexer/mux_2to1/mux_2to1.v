// Design Module

module mux_2to1 #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  input sel,
  output [Width-1:0] out
);
assign out= sel? in1: in0;
endmodule

// Testbench Module

module tb_mux_2to1;
localparam Width= 2;
reg [Width-1:0] in0, in1;
reg sel;
wire [Width-1:0] out;
integer i;

mux_2to1 #(.Width(Width)) dut(.in0(in0), .in1(in1), .sel(sel), .out(out));

initial begin
  for(i= 0; i< 2** (2* Width+ 1); i+= 1) begin
    {in0, in1, sel}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_mux_2to1);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IN0|IN1|SEL|OUT|");
  $display("|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|", $time, in0, in1, sel, out);
end
endmodule
