// Design Module

module mux_8to1 #(parameter Width= 1)(
  input [Width-1:0] i0, i1, i2, i3, i4, i5, i6, i7,
  input [2:0] sel,
  output reg [Width-1:0] y
);
always @(*) begin
  case(sel)
    3'b000: y= i0;
    3'b001: y= i1;
    3'b010: y= i2;
    3'b011: y= i3;
    3'b100: y= i4;
    3'b101: y= i5;
    3'b110: y= i6;
    3'b111: y= i7;
    default: y= 'b0;
  endcase
end
endmodule

// Testbench Module

module tb_mux_8to1;
localparam Width= 1;
reg [Width-1:0] i0, i1, i2, i3, i4, i5, i6, i7;
reg [2:0] sel;
wire [Width-1:0] y;
integer i;

mux_8to1 #(.Width(Width)) dut(.i0(i0), .i1(i1), .i2(i2), .i3(i3), .i4(i4), .i5(i5), .i6(i6), .i7(i7), .sel(sel), .y(y));

initial begin
  for(i= 0; i< 2** (8* Width+ 4); i+= 1) begin
    {i0, i1, i2, i3, i4, i5, i6, i7, sel}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_mux_8to1);
  $display("Bit Width= %0d", Width);
  $display("|TIME|I0|I1|I2|I3|I4|I5|I6|I7|SEL|Y|");
  $display("|-|-|-|-|-|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|%b|%b|%b|%b|%b|", $time, i0, i1, i2, i3, i4, i5, i6, i7, sel, y);
end
endmodule
