// Design Module

module mux_4to1 #(parameter Width= 1)(
  input [Width-1:0] i0, i1, i2, i3,
  input [1:0] sel,
  output reg [Width-1:0] y
);
always @(*) begin
  case(sel)
    2'b00: y= i0;
    2'b01: y= i1;
    2'b10: y= i2;
    2'b11: y= i3;
    default: y= 'b0;
  endcase
end
endmodule

// Testbench Module

module tb_mux_4to1;
localparam Width= 1;
reg [Width-1:0] i0, i1, i2, i3;
reg [1:0] sel;
wire [Width-1:0] y;
integer i;

mux_4to1 #(.Width(Width)) dut(.i0(i0), .i1(i1), .i2(i2), .i3(i3), .sel(sel), .y(y));

initial begin
  for(i= 0; i< 2** (4* Width+ 2); i+= 1) begin
    {i0, i1, i2, i3, sel}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_mux_4to1);
  $display("Bit Width= %0d", Width);
  $display("|TIME|I0|I1|I2|I3|SEL|Y|");
  $display("|-|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|%b|", $time, i0, i1, i2, i3, sel, y);
end
endmodule
