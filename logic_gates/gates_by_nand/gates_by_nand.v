// Design Module

module gates_by_nand #(parameter Width= 1)(
  input [Width-1:0] a, b,
  output [Width-1:0] y_and, y_or, y_not, y_nand, y_nor, y_xor, y_xnor
);
and_gate #(.Width(Width)) u_and(.a(a), .b(b), .y(y_and));
or_gate #(.Width(Width)) u_or(.a(a), .b(b), .y(y_or));
not_gate #(.Width(Width)) u_not(.a(a), .y(y_not));
nand_gate #(.Width(Width)) u_nand(.a(a), .b(b), .y(y_nand));
nor_gate #(.Width(Width)) u_nor(.a(a), .b(b), .y(y_nor));
xor_gate #(.Width(Width)) u_xor(.a(a), .b(b), .y(y_xor));
xnor_gate #(.Width(Width)) u_xnor(.a(a), .b(b), .y(y_xnor));
endmodule

module nand_gate #(parameter Width= 1)(
  input [Width-1:0] a, b,
  output [Width-1:0] y
);
assign y= a~& b;
endmodule

module and_gate #(parameter Width= 1)(
  input [Width-1:0] a, b,
  output [Width-1:0] y
);
wire [Width-1:0] y_n;
nand_gate #(.Width(Width)) u1(.a(a), .b(b), .y(y_n));
nand_gate #(.Width(Width)) u2(.a(y_n), .b(y_n), .y(y));
endmodule

module or_gate #(parameter Width= 1)(
  input [Width-1:0] a, b,
  output [Width-1:0] y
);
wire [Width-1:0] a_n, b_n;
nand_gate #(.Width(Width)) u1(.a(a), .b(a), .y(a_n));
nand_gate #(.Width(Width)) u2(.a(b), .b(b), .y(b_n));
nand_gate #(.Width(Width)) u3(.a(a_n), .b(b_n), .y(y));
endmodule

module not_gate #(parameter Width= 1)(
  input [Width-1:0] a,
  output [Width-1:0] y
);
nand_gate #(.Width(Width)) u1(.a(a), .b(a), .y(y));
endmodule

module nor_gate #(parameter Width= 1)(
  input [Width-1:0] a, b,
  output [Width-1:0] y
);
wire [Width-1:0] a_n, b_n, y_n;
nand_gate #(.Width(Width)) u1(.a(a), .b(a), .y(a_n));
nand_gate #(.Width(Width)) u2(.a(b), .b(b), .y(b_n));
nand_gate #(.Width(Width)) u3(.a(a_n), .b(b_n), .y(y_n));
nand_gate #(.Width(Width)) u4(.a(y_n), .b(y_n), .y(y));
endmodule

module xor_gate #(parameter Width= 1)(
  input [Width-1:0] a, b,
  output [Width-1:0] y
);
wire [Width-1:0] y1, y2, y3;
nand_gate #(.Width(Width)) u1(.a(a), .b(b), .y(y1));
nand_gate #(.Width(Width)) u2(.a(a), .b(y1), .y(y2));
nand_gate #(.Width(Width)) u3(.a(y1), .b(b), .y(y3));
nand_gate #(.Width(Width)) u4(.a(y2), .b(y3), .y(y));
endmodule

module xnor_gate #(parameter Width= 1)(
  input [Width-1:0] a, b,
  output [Width-1:0] y
);
wire [Width-1:0] y1, y2, y3, y_n;
nand_gate #(.Width(Width)) u1(.a(a), .b(b), .y(y1));
nand_gate #(.Width(Width)) u2(.a(a), .b(y1), .y(y2));
nand_gate #(.Width(Width)) u3(.a(y1), .b(b), .y(y3));
nand_gate #(.Width(Width)) u4(.a(y2), .b(y3), .y(y_n));
nand_gate #(.Width(Width)) u5(.a(y_n), .b(y_n), .y(y));
endmodule

// Testbench Module

module tb;
localparam Width= 2;
reg [Width-1:0] a, b;
wire [Width-1:0] y_and, y_or, y_not, y_nand, y_nor, y_xor, y_xnor;

integer i;
gates_by_nand #(.Width(Width)) dut(.a(a), .b(b), .y_and(y_and), .y_or(y_or), .y_not(y_not), .y_nand(y_nand), .y_nor(y_nor), .y_xor(y_xor), .y_xnor(y_xnor));

initial begin
  for(i= 0; i< 2** (2* Width); i+= 1) begin
    {a, b}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb);
  $display("Bit Width= %0d", Width);
  $display("|TIME|A|B|AND|OR|NOT|NAND|NOR|XOR|XNOR|");
  $display("|-|-|-|-|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|%b|%b|%b|%b|", $time, a, b, y_and, y_or, y_not, y_nand, y_nor, y_xor, y_xnor);
end
endmodule
