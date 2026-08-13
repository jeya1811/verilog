// Design Module

module alu_2 #(parameter Width= 1)(
  input opcode,
  input [Width-1:0] in0, in1,
  output [Width-1:0] out,
  output zero, carry, sign, overflow
);
mux_2to1 #(.Width(Width)) u_mux_2to1(.in0(in0), .in1(in1), .sel(opcode), .out(out), .carry(carry));
assign zero= (out== 'b0);
assign sign= out[Width-1];
assign overflow= (opcode== 1'b0)? (~(in0[Width-1]^ in1[Width-1]))& (out[Width-1]^ in0[Width-1]):
                                  (in0[Width-1]^ in1[Width-1])& (out[Width-1]^ in0[Width-1]);
endmodule

module mux_2to1 #(parameter Width= 1)(
  input [Width-1:0] in0, in1,
  input sel,
  output reg [Width-1:0] out,
  output reg carry
);
wire [Width-1:0] out_add, out_sub;
wire cout_add, bout_sub;
add #(.Width(Width)) u_add(.in0(in0), .in1(in1), .out(out_add), .cout(cout_add));
sub #(.Width(Width)) u_sub(.in0(in0), .in1(in1), .out(out_sub), .bout(bout_sub));
always @(*) begin
  carry= 'bx;
  case(sel)
    1'b0: begin
      out= out_add;
      carry= cout_add;
    end
    1'b1: begin
      out= out_sub;
      carry= bout_sub;
    end
    default: begin
      out= 'bx;
      carry= 'bx;
    end
  endcase
end
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

// Testbench Module

module tb_alu_2;
localparam Width= 1;
reg [Width-1:0] in0, in1;
reg opcode;
wire [Width-1:0] out;
wire zero, carry, sign, overflow;
integer i;

alu_2 #(.Width(Width)) dut(.opcode(opcode), .in0(in0), .in1(in1), .out(out), .zero(zero), .carry(carry), .sign(sign), .overflow(overflow));

initial begin
  for(i= 0; i< 2** (2* Width+ 1); i+= 1) begin
    {opcode, in0, in1}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_alu_2);
  $display("Bit Width= %0d", Width);
  $display("|TIME|OPCODE|IN0|IN1|OUT|ZERO|CARRY|SIGN|OVERFLOW|");
  $display("|-|-|-|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|%b|%b|%b|", $time, opcode, in0, in1, out, zero, carry, sign, overflow);
end
endmodule
