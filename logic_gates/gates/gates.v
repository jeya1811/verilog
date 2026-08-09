// Design Module

module gates #(parameter Width= 1)(
  input [Width-1:0] ip0, ip1,
  output [Width-1:0] op_and, op_or, op_not, op_nand, op_nor, op_xor, op_xnor
);
and_gate #(.Width(Width)) u_and(.ip0(ip0), .ip1(ip1), .op(op_and));
or_gate #(.Width(Width)) u_or(.ip0(ip0), .ip1(ip1), .op(op_or));
not_gate #(.Width(Width)) u_not(.ip0(ip0), .op(op_not));
nand_gate #(.Width(Width)) u_nand(.ip0(ip0), .ip1(ip1), .op(op_nand));
nor_gate #(.Width(Width)) u_nor(.ip0(ip0), .ip1(ip1), .op(op_nor));
xor_gate #(.Width(Width)) u_xor(.ip0(ip0), .ip1(ip1), .op(op_xor));
xnor_gate #(.Width(Width)) u_xnor(.ip0(ip0), .ip1(ip1), .op(op_xnor));
endmodule

module and_gate #(parameter Width= 1)(
  input [Width-1:0] ip0, ip1,
  output [Width-1:0] op
);
assign op= ip0& ip1;
endmodule

module or_gate #(parameter Width= 1)(
  input [Width-1:0] ip0, ip1,
  output [Width-1:0] op
);
assign op= ip0| ip1;
endmodule

module not_gate #(parameter Width= 1)(
  input [Width-1:0] ip0,
  output [Width-1:0] op
);
assign op= ~ip0;
endmodule

module nand_gate #(parameter Width= 1)(
  input [Width-1:0] ip0, ip1,
  output [Width-1:0] op
);
assign op= ip0~& ip1;
endmodule

module nor_gate #(parameter Width= 1)(
  input [Width-1:0] ip0, ip1,
  output [Width-1:0] op
);
assign op= ip0~| ip1;
endmodule

module xor_gate #(parameter Width= 1)(
  input [Width-1:0] ip0, ip1,
  output [Width-1:0] op
);
assign op= ip0^ ip1;
endmodule

module xnor_gate #(parameter Width= 1)(
  input [Width-1:0] ip0, ip1,
  output [Width-1:0] op
);
assign op= ip0~^ ip1;
endmodule

// Testbench Module

module tb_gates;
localparam Width= 2;
reg [Width-1:0] ip0, ip1;
wire [Width-1:0] op_and, op_or, op_not, op_nand, op_nor, op_xor, op_xnor;

integer i;
gates #(.Width(Width)) dut(.ip0(ip0), .ip1(ip1), .op_and(op_and), .op_or(op_or), .op_not(op_not), .op_nand(op_nand), .op_nor(op_nor), .op_xor(op_xor), .op_xnor(op_xnor));

initial begin
  for(i= 0; i< 2** (2* Width); i+= 1) begin
    {ip0, ip1}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_gates);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IP0|IP1|AND|OR|NOT|NAND|NOR|XOR|XNOR|");
  $display("|-|-|-|-|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|%b|%b|%b|%b|", $time, ip0, ip1, op_and, op_or, op_not, op_nand, op_nor, op_xor, op_xnor);
end
endmodule
