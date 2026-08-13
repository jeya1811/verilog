// Design Module

module alu_8 #(parameter Width= 1)(
  input [2:0] opcode,
  input [Width-1:0] in0, in1,
  output [Width-1:0] out,
  output zero, carry, sign, overflow
);
mux_8to1 #(.Width(Width)) u_mux_8to1(.in0(in0), .in1(in1), .sel(opcode), .out(out), .carry(carry));
assign zero= (out== 'b0);
assign sign= out[Width-1];
assign overflow= (opcode== 3'b100)? (~(in0[Width-1]^ in1[Width-1]))& (out[Width-1]^ in0[Width-1]):
                 (opcode== 3'b101)? (in0[Width-1]^ in1[Width-1])& (out[Width-1]^ in0[Width-1]): 'bx;
endmodule

module mux_8to1 #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  input [2:0] sel,
  output reg [Width-1:0] out,
  output reg carry
);
wire [Width-1:0] out_and, out_or, out_not, out_xor, out_add, out_sub, out_left_shift, out_right_shift;
wire cout_add, bout_sub, cout_left_shift, cout_right_shift;
and_gate #(.Width(Width)) u_and_gate(.in0(in0), .in1(in1), .out(out_and));
or_gate #(.Width(Width)) u_or_gate(.in0(in0), .in1(in1), .out(out_or));
not_gate #(.Width(Width)) u_not_gate(.in(in0), .out(out_not));
xor_gate #(.Width(Width)) u_xor_gate(.in0(in0), .in1(in1), .out(out_xor));
add #(.Width(Width)) u_add(.in0(in0), .in1(in1), .out(out_add), .cout(cout_add));
sub #(.Width(Width)) u_sub(.in0(in0), .in1(in1), .out(out_sub), .bout(bout_sub));
left_shift #(.Width(Width)) u_left_shift(.in(in0), .out(out_left_shift), .cout(cout_left_shift));
right_shift #(.Width(Width)) u_right_shift(.in(in0), .out(out_right_shift), .cout(cout_right_shift));
always @(*) begin
  carry= 'bx;
  case(sel)
    3'b000: out= out_and;
    3'b001: out= out_or;
    3'b010: out= out_not;
    3'b011: out= out_xor;
    3'b100: begin
      out= out_add;
      carry= cout_add;
    end
    3'b101: begin
      out= out_sub;
      carry= bout_sub;
    end
    3'b110: begin
      out= out_left_shift;
      carry= cout_left_shift;
    end
    3'b111: begin
      out= out_right_shift;
      carry= cout_right_shift;
    end
    default: begin
      out= 'bx;
      carry= 'bx;
    end
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
  input [Width-1:0] in,
  output [Width-1:0] out
);
assign out= ~in;
endmodule

module xor_gate #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  output [Width-1:0] out
);
assign out= in0^ in1;
endmodule

module add #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  output [Width-1:0] out,
  output cout
);
assign {cout, out}= in0+ in1;
endmodule

module sub #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  output [Width-1:0] out,
  output bout
);
assign out= in0- in1;
assign bout= in0< in1;
endmodule

module left_shift #(parameter Width= 1)(
  input [Width-1:0] in,
  output [Width-1:0] out,
  output cout
);
assign out= in<< 1;
assign cout= in[Width-1];
endmodule

module right_shift #(parameter Width= 1)(
  input [Width-1:0] in,
  output [Width-1:0] out,
  output cout
);
assign out= in>> 1;
assign cout= in[0];
endmodule

// Testbench Module

module tb_alu_8;
localparam Width= 2;
reg [Width-1:0] in0, in1;
reg [2:0] opcode;
wire [Width-1:0] out;
wire zero, carry, sign, overflow;
integer i;

alu_8 #(.Width(Width)) dut(.opcode(opcode), .in0(in0), .in1(in1), .out(out), .zero(zero), .carry(carry), .sign(sign), .overflow(overflow));

initial begin
  for(i= 0; i< 2** (2* Width+ 3); i+= 1) begin
    {opcode, in0, in1}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_alu_8);
  $display("Bit Width= %0d", Width);
  $display("|TIME|OPCODE|IN0|IN1|OUT|ZERO|CARRY|SIGN|OVERFLOW|");
  $display("|-|-|-|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|%b|%b|%b|", $time, opcode, in0, in1, out, zero, carry, sign, overflow);
end
endmodule
