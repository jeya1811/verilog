// Design Module

module demux_1to2 #(parameter Width= 1)(
  input [Width-1:0] data,
  input sel,
  output [Width-1:0] out0, out1
);
assign out0= sel? 'b0: data;
assign out1= sel? data: 'b0;
endmodule

// Testbench Module

module tb;
localparam Width= 2;
reg [Width-1:0] data;
reg sel;
wire [Width-1:0] out0, out1;
integer i;

demux_1to2 #(.Width(Width)) dut(.data(data), .sel(sel), .out0(out0), .out1(out1));

initial begin
  for(i= 0; i< 2** (Width+ 1); i+= 1) begin
    {data, sel}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb);
  $display("Bit Width= %0d", Width);
  $display("|TIME|DATA|SEL|OUT0|OUT1|");
  $display("|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|", $time, data, sel, out0, out1);
end
endmodule
