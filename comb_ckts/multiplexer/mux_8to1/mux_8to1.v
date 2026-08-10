// Design Module

module mux_8to1 #(parameter Width= 1)(
  input [Width-1:0] in0, in1, in2, in3, in4, in5, in6, in7,
  input [2:0] sel,
  output reg [Width-1:0] out
);
always @(*) begin
  case(sel)
    3'b000: out= in0;
    3'b001: out= in1;
    3'b010: out= in2;
    3'b011: out= in3;
    3'b100: out= in4;
    3'b101: out= in5;
    3'b110: out= in6;
    3'b111: out= in7;
    default: out= 'b0;
  endcase
end
endmodule

// Testbench Module

module tb_mux_8to1;
localparam Width= 1;
reg [Width-1:0] in0, in1, in2, in3, in4, in5, in6, in7;
reg [2:0] sel;
wire [Width-1:0] out;
integer i;

mux_8to1 #(.Width(Width)) dut(.in0(in0), .in1(in1), .in2(in2), .in3(in3), .in4(in4), .in5(in5), .in6(in6), .in7(in7), .sel(sel), .out(out));

initial begin
  for(i= 0; i< 2** (8* Width+ 4); i+= 1) begin
    {in0, in1, in2, in3, in4, in5, in6, in7, sel}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_mux_8to1);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IN0|IN1|IN2|IN3|IN4|IN5|IN6|IN7|SEL|OUT|");
  $display("|-|-|-|-|-|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|%b|%b|%b|%b|%b|", $time, in0, in1, in2, in3, in4, in5, in6, in7, sel, out);
end
endmodule
