// Design Module

module demux_1to8 #(parameter Width= 1)(
  input [Width-1:0] data,
  input [2:0] sel,
  output reg [Width-1:0] out0, out1, out2, out3, out4, out5, out6, out7
);
always @(*) begin
  out0= 'b0;
  out1= 'b0;
  out2= 'b0;
  out3= 'b0;
  out4= 'b0;
  out5= 'b0;
  out6= 'b0;
  out7= 'b0;
  case(sel)
    3'b000: out0= data;
    3'b001: out1= data;
    3'b010: out2= data;
    3'b011: out3= data;
    3'b100: out4= data;
    3'b101: out5= data;
    3'b110: out6= data;
    3'b111: out7= data;
  endcase
end
endmodule

// Testbench Module

module tb;
localparam Width= 2;
reg [Width-1:0] data;
reg [2:0] sel;
wire [Width-1:0] out0, out1, out2, out3, out4, out5, out6, out7;
integer i;

demux_1to8 #(.Width(Width)) dut(.data(data), .sel(sel), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .out4(out4), .out5(out5), .out6(out6), .out7(out7));

initial begin
  for(i= 0; i< 2** (Width+ 3); i+= 1) begin
    {data, sel}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb);
  $display("Bit Width= %0d", Width);
  $display("|TIME|DATA|SEL|OUT0|OUT1|OUT2|OUT3|OUT4|OUT5|OUT6|OUT7|");
  $display("|-|-|-|-|-|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|%b|%b|%b|%b|%b|", $time, data, sel, out0, out1, out2, out3, out4, out5, out6, out7);
end
endmodule
