// Design Module

module alu_4 #(parameter Width= 1)(
  input [1:0] opcode,
  input [Width-1:0] in0, in1,
  output [Width-1:0] out,
  output zero
);
mux_4to1 #(.Width(Width)) u_mux_4to1(.in0(in0), .in1(in1), .sel(opcode), .out(out));
assign zero= (out== 'b0);
endmodule

module mux_4to1 #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  input [1:0] sel,
  output reg [Width-1:0] out
);
wire [Width-1:0] out_and, out_or, out_not, out_xor;
and_gate #(.Width(Width)) u_and_gate(.in0(in0), .in1(in1), .out(out_and));
or_gate #(.Width(Width)) u_or_gate(.in0(in0), .in1(in1), .out(out_or));
not_gate #(.Width(Width)) u_not_gate(.ip(in0), .out(out_not));
xor_gate #(.Width(Width)) u_xor_gate(.in0(in0), .in1(in1), .out(out_xor));
always @(*) begin
  case(sel)
    2'b00: out= out_and;
    2'b01: out= out_or;
    2'b10: out= out_not;
    2'b11: out= out_xor;
    default: out= 'b0;
  endcase
end
endmodule

module and_gate #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  output [Width-1:0] out
);
assign out= in0& in1;
endmodule

module or_gate #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  output [Width-1:0] out
);
assign out= in0| in1;
endmodule

module not_gate #(parameter Width= 1)(
  input [Width-1:0] ip,
  output [Width-1:0] out
);
assign out= ~ip;
endmodule

module xor_gate #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  output [Width-1:0] out
);
assign out= in0^ in1;
endmodule

// Testbench Module

module tb_alu_4;
localparam Width= 1;
reg [Width-1:0] in0, in1;
reg [1:0] opcode;
wire [Width-1:0] out;
wire zero;
integer i;

alu_4 #(.Width(Width)) dut(.opcode(opcode), .in0(in0), .in1(in1), .out(out), .zero(zero));

initial begin
  for(i= 0; i< 2** (2* Width+ 2); i+= 1) begin
    {opcode, in0, in1}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_alu_4);
  $display("Bit Width= %0d", Width);
  $display("|TIME|OPCODE|IN0|IN1|OUT|ZERO|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, opcode, in0, in1, out, zero);
end
endmodule
