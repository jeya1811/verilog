// Design Module

module demux_1to4 #(parameter Width= 1)(
  input [Width-1:0] data,
  input [1:0] sel,
  output reg [Width-1:0] out0, out1, out2, out3
);
always @(*) begin
  out0= 'b0;
  out1= 'b0;
  out2= 'b0;
  out3= 'b0;
  case(sel)
    2'b00: out0= data;
    2'b01: out1= data;
    2'b10: out2= data;
    2'b11: out3= data;
  endcase
end
endmodule

// Testbench Module

module tb_demux_1to4;
localparam Width= 2;
reg [Width-1:0] data;
reg [1:0] sel;
wire [Width-1:0] out0, out1, out2, out3;
integer i;

demux_1to4 #(.Width(Width)) dut(.data(data), .sel(sel), .out0(out0), .out1(out1), .out2(out2), .out3(out3));

initial begin
  for(i= 0; i< 2** (Width+ 2); i+= 1) begin
    {data, sel}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_demux_1to4);
  $display("Bit Width= %0d", Width);
  $display("|TIME|DATA|SEL|OUT0|OUT1|OUT2|OUT3|");
  $display("|-|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|%b|", $time, data, sel, out0, out1, out2, out3);
end
endmodule
