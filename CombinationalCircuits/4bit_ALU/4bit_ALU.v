/*  4bit ALU  */

// Logical Operation
module fourBit_and (
  input [3:0] a,
  input [3:0] b,
  output [3:0] y
);
  assign y = a & b;
endmodule

module fourBit_or (
  input [3:0] a,
  input [3:0] b,
  output [3:0] y
);
  assign y = a | b;
endmodule

module fourBit_not_a (
  input [3:0] a,
  output [3:0] y
);
  assign y = ~a;
endmodule

module fourBit_not_b (
  input [3:0] b,
  output [3:0] y
);
  assign y = ~b;
endmodule

module fourBit_nand (
  input [3:0] a,
  input [3:0] b,
  output [3:0] y
);
  assign y = ~(a & b);
endmodule

module fourBit_nor (
  input [3:0] a,
  input [3:0] b,
  output [3:0] y
);
  assign y = ~(a | b);
endmodule

module fourBit_xor (
  input [3:0] a,
  input [3:0] b,
  output [3:0] y
);
  assign y = a ^ b;
endmodule

module fourBit_xnor (
  input [3:0] a,
  input [3:0] b,
  output [3:0] y
);
  assign y = ~(a ^ b);
endmodule

// Arithmetic Operation

module fourBit_adder (
  input [3:0] a,
  input [3:0] b,
  output [3:0] y,
  output carry
);
  assign {carry, y} = a + b;
endmodule

module fourBit_subtractor (
  input [3:0] a,
  input [3:0] b,
  output [3:0] y,
  output carry
);
  assign {carry, y} = a + (~b + 1);
endmodule

// Shift Operation

module fourBit_shiftLeft_a (
  input [3:0] a,
  output [3:0] y
);
  assign y = a << 1;
endmodule

module fourBit_shiftRight_a (
  input [3:0] a,
  output [3:0] y
);
  assign y = a >> 1;
endmodule

module fourBit_shiftLeft_b (
  input [3:0] b,
  output [3:0] y
);
  assign y = b << 1;
endmodule

module fourBit_shiftRight_b (
  input [3:0] b,
  output [3:0] y
);
  assign y = b >> 1;
endmodule

// Relational Operation

module fourBit_lessThan_a (
  input [3:0] a,
  input [3:0] b,
  output y
);
  assign y = (a < b);
endmodule

module fourBit_equalTo_a (
  input [3:0] a,
  input [3:0] b,
  output y
);
  assign y = (a == b);
endmodule

// Multiplexer

module multiplexer (
  // operation code
  input [3:0] opcode,
  // arithmetic operation
  input [3:0] adder_op,
  input [3:0] subtractor_op,
  // shift operation
  input [3:0] shiftLeft_a_op,
  input [3:0] shiftRight_a_op,
  input [3:0] shiftLeft_b_op,
  input [3:0] shiftRight_b_op,
  // relational operation
  input lessThan_a_op,
  input equalTo_a_op,
  // logical operation
  input [3:0] and_op,
  input [3:0] or_op,
  input [3:0] not_a_op,
  input [3:0] not_b_op,
  input [3:0] nand_op,
  input [3:0] nor_op,
  input [3:0] xor_op,
  input [3:0] xnor_op,
  // carry
  input adder_carry,
  input subtractor_carry,
  // output
  output reg [3:0] out,
  output reg carry,
  output reg zero
);
  always @(*) begin
    carry = 0;
    zero  = 0;
    case (opcode)
      4'b0000: {carry, out} = {adder_carry, adder_op};
      4'b0001: {carry, out} = {subtractor_carry, subtractor_op};
      4'b0010: out = shiftLeft_a_op;
      4'b0011: out = shiftRight_a_op;
      4'b0100: out = shiftLeft_b_op;
      4'b0101: out = shiftRight_b_op;
      4'b0110: out = lessThan_a_op;
      4'b0111: out = equalTo_a_op;
      4'b1000: out = and_op;
      4'b1001: out = or_op;
      4'b1010: out = not_a_op;
      4'b1011: out = not_b_op;
      4'b1100: out = nand_op;
      4'b1101: out = nor_op;
      4'b1110: out = xor_op;
      4'b1111: out = xnor_op;
    endcase
    zero = (out == 4'b0000);
  end
endmodule

// ALU_Module

module fourBit_ALU (
  input [3:0] a,
  input [3:0] b,
  input [3:0] opcode,
  output [3:0] out,
  output carry,
  output zero
);

  wire [3:0] adder_op, subtractor_op, shiftLeft_a_op, shiftRight_a_op, shiftLeft_b_op, shiftRight_b_op;
  wire [3:0] and_op, or_op, not_a_op, not_b_op, nand_op, nor_op, xor_op, xnor_op;
  wire adder_carry, subtractor_carry, lessThan_a_op, equalTo_a_op;

  // arithmetic operation
  fourBit_adder u_adder (
    .a(a),
    .b(b),
    .y(adder_op),
    .carry(adder_carry)
  );
  fourBit_subtractor u_subtractor (
    .a(a),
    .b(b),
    .y(subtractor_op),
    .carry(subtractor_carry)
  );
  // shift operation
  fourBit_shiftLeft_a u_shiftLeft_a (
    .a(a),
    .y(shiftLeft_a_op)
  );
  fourBit_shiftRight_a u_shiftRight_a (
    .a(a),
    .y(shiftRight_a_op)
  );
  fourBit_shiftLeft_b u_shiftLeft_b (
    .b(b),
    .y(shiftLeft_b_op)
  );
  fourBit_shiftRight_b u_shiftRight_b (
    .b(b),
    .y(shiftRight_b_op)
  );
  // relational operation
  fourBit_lessThan_a u_lessThan_a (
    .a(a),
    .b(b),
    .y(lessThan_a_op)
  );
  fourBit_equalTo_a u_equalTo_a (
    .a(a),
    .b(b),
    .y(equalTo_a_op)
  );
  // logical operation
  fourBit_and u_and (
    .a(a),
    .b(b),
    .y(and_op)
  );
  fourBit_or u_or (
    .a(a),
    .b(b),
    .y(or_op)
  );
  fourBit_not_a u_not_a (
    .a(a),
    .y(not_a_op)
  );
  fourBit_not_b u_not_b (
    .b(b),
    .y(not_b_op)
  );
  fourBit_nand u_nand (
    .a(a),
    .b(b),
    .y(nand_op)
  );
  fourBit_nor u_nor (
    .a(a),
    .b(b),
    .y(nor_op)
  );
  fourBit_xor u_xor (
    .a(a),
    .b(b),
    .y(xor_op)
  );
  fourBit_xnor u_xnor (
    .a(a),
    .b(b),
    .y(xnor_op)
  );

  multiplexer u_mux (
    .opcode(opcode),
    .adder_op(adder_op),
    .subtractor_op(subtractor_op),
    .shiftLeft_a_op(shiftLeft_a_op),
    .shiftRight_a_op(shiftRight_a_op),
    .shiftLeft_b_op(shiftLeft_b_op),
    .shiftRight_b_op(shiftRight_b_op),
    .lessThan_a_op(lessThan_a_op),
    .equalTo_a_op(equalTo_a_op),
    .and_op(and_op),
    .or_op(or_op),
    .not_a_op(not_a_op),
    .not_b_op(not_b_op),
    .nand_op(nand_op),
    .nor_op(nor_op),
    .xor_op(xor_op),
    .xnor_op(xnor_op),
    .adder_carry(adder_carry),
    .subtractor_carry(subtractor_carry),
    .out(out),
    .carry(carry),
    .zero(zero)
  );
endmodule
