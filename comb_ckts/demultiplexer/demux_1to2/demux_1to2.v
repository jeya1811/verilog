// Design Module

module demux_1to2 #(parameter Width= 1)(
  input [Width-1:0] in,
  input sel,
  output [Width-1:0] out0, out1
);
assign out0= sel? 'b0: in;
assign out1= sel? in: 'b0;
endmodule

// Testbench Module

module tb_demux_1to2;
localparam Width= 2;
reg [Width-1:0] in;
reg sel;
wire [Width-1:0] out0, out1;
integer i;

demux_1to2 #(.Width(Width)) dut(.in(in), .sel(sel), .out0(out0), .out1(out1));

initial begin
  for(i= 0; i< 2** (Width+ 1); i+= 1) begin
    {in, sel}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_demux_1to2);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IN|SEL|OUT0|OUT1|");
  $display("|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|", $time, in, sel, out0, out1);
end
endmodule
