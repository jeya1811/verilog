// Design Module

module gates #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  output [Width-1:0] out_and, out_or, out_not, out_nand, out_nor, out_xor, out_xnor
);
and_gate #(.Width(Width)) u_and(.in0(in0), .in1(in1), .out(out_and));
or_gate #(.Width(Width)) u_or(.in0(in0), .in1(in1), .out(out_or));
not_gate #(.Width(Width)) u_not(.in(in0), .out(out_not));
nand_gate #(.Width(Width)) u_nand(.in0(in0), .in1(in1), .out(out_nand));
nor_gate #(.Width(Width)) u_nor(.in0(in0), .in1(in1), .out(out_nor));
xor_gate #(.Width(Width)) u_xor(.in0(in0), .in1(in1), .out(out_xor));
xnor_gate #(.Width(Width)) u_xnor(.in0(in0), .in1(in1), .out(out_xnor));
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
  input [Width-1:0] in,
  output [Width-1:0] out
);
assign out= ~in;
endmodule

module nand_gate #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  output [Width-1:0] out
);
assign out= in0~& in1;
endmodule

module nor_gate #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  output [Width-1:0] out
);
assign out= in0~| in1;
endmodule

module xor_gate #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  output [Width-1:0] out
);
assign out= in0^ in1;
endmodule

module xnor_gate #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  output [Width-1:0] out
);
assign out= in0~^ in1;
endmodule

// Testbench Module

module tb_gates;
localparam Width= 2;
reg [Width-1:0] in0, in1;
wire [Width-1:0] out_and, out_or, out_not, out_nand, out_nor, out_xor, out_xnor;

integer i;
gates #(.Width(Width)) dut(.in0(in0), .in1(in1), .out_and(out_and), .out_or(out_or), .out_not(out_not), .out_nand(out_nand), .out_nor(out_nor), .out_xor(out_xor), .out_xnor(out_xnor));

initial begin
  for(i= 0; i< 2** (2* Width); i+= 1) begin
    {in0, in1}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_gates);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IN0|IN1|AND|OR|NOT|NAND|NOR|XOR|XNOR|");
  $display("|-|-|-|-|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|%b|%b|%b|%b|", $time, in0, in1, out_and, out_or, out_not, out_nand, out_nor, out_xor, out_xnor);
end
endmodule
