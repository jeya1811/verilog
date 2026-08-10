// Design Module

module gates_by_nand #(parameter Width= 1)(
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

module nand_gate #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  output [Width-1:0] out
);
assign out= in0~& in1;
endmodule

module and_gate #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  output [Width-1:0] out
);
wire [Width-1:0] out_n;
nand_gate #(.Width(Width)) u1(.in0(in0), .in1(in1), .out(out_n));
nand_gate #(.Width(Width)) u2(.in0(out_n), .in1(out_n), .out(out));
endmodule

module or_gate #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  output [Width-1:0] out
);
wire [Width-1:0] in0_n, in1_n;
nand_gate #(.Width(Width)) u1(.in0(in0), .in1(in0), .out(in0_n));
nand_gate #(.Width(Width)) u2(.in0(in1), .in1(in1), .out(in1_n));
nand_gate #(.Width(Width)) u3(.in0(in0_n), .in1(in1_n), .out(out));
endmodule

module not_gate #(parameter Width= 1)(
  input [Width-1:0] in,
  output [Width-1:0] out
);
nand_gate #(.Width(Width)) u1(.in0(in), .in1(in), .out(out));
endmodule

module nor_gate #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  output [Width-1:0] out
);
wire [Width-1:0] in0_n, in1_n, out_n;
nand_gate #(.Width(Width)) u1(.in0(in0), .in1(in0), .out(in0_n));
nand_gate #(.Width(Width)) u2(.in0(in1), .in1(in1), .out(in1_n));
nand_gate #(.Width(Width)) u3(.in0(in0_n), .in1(in1_n), .out(out_n));
nand_gate #(.Width(Width)) u4(.in0(out_n), .in1(out_n), .out(out));
endmodule

module xor_gate #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  output [Width-1:0] out
);
wire [Width-1:0] t0, t1, t2;
nand_gate #(.Width(Width)) u1(.in0(in0), .in1(in1), .out(t0));
nand_gate #(.Width(Width)) u2(.in0(in0), .in1(t0), .out(t1));
nand_gate #(.Width(Width)) u3(.in0(t0), .in1(in1), .out(t2));
nand_gate #(.Width(Width)) u4(.in0(t1), .in1(t2), .out(out));
endmodule

module xnor_gate #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  output [Width-1:0] out
);
wire [Width-1:0] t0, t1, t2, out_n;
nand_gate #(.Width(Width)) u1(.in0(in0), .in1(in1), .out(t0));
nand_gate #(.Width(Width)) u2(.in0(in0), .in1(t0), .out(t1));
nand_gate #(.Width(Width)) u3(.in0(t0), .in1(in1), .out(t2));
nand_gate #(.Width(Width)) u4(.in0(t1), .in1(t2), .out(out_n));
nand_gate #(.Width(Width)) u5(.in0(out_n), .in1(out_n), .out(out));
endmodule

// Testbench Module

module tb_gates_by_nand;
localparam Width= 2;
reg [Width-1:0] in0, in1;
wire [Width-1:0] out_and, out_or, out_not, out_nand, out_nor, out_xor, out_xnor;

integer i;
gates_by_nand #(.Width(Width)) dut(.in0(in0), .in1(in1), .out_and(out_and), .out_or(out_or), .out_not(out_not), .out_nand(out_nand), .out_nor(out_nor), .out_xor(out_xor), .out_xnor(out_xnor));

initial begin
  for(i= 0; i< 2** (2* Width); i+= 1) begin
    {in0, in1}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_gates_by_nand);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IN0|IN1|AND|OR|NOT|NAND|NOR|XOR|XNOR|");
  $display("|-|-|-|-|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|%b|%b|%b|%b|", $time, in0, in1, out_and, out_or, out_not, out_nand, out_nor, out_xor, out_xnor);
end
endmodule
