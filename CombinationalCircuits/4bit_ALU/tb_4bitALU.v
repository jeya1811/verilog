`timescale 1ns / 1ps

module tb_fourbitALU;

  reg [3:0] a, b;
  reg  [3:0] opcode;
  wire [3:0] out;
  wire carry, zero;

  fourBit_ALU u_4bitALU (
    .a(a),
    .b(b),
    .opcode(opcode),
    .out(out),
    .carry(carry),
    .zero(zero)
  );

  initial begin
    $dumpfile("4bit_ALU_waves.vcd");
    $dumpvars(0, tb_fourbitALU);
    $display("|a|b|opcode|out|carry|zero|");
    $display("|-|-|-|-|-|-|");
    for (integer i = 0; i < 16; i += 1) begin
      for (integer j = 0; j < 16; j += 1) begin
        for (integer k = 0; k < 16; k += 1) begin
          a = i;
          b = j;
          opcode = k;
          #10;
          $display("|%b|%b|%b|%b|%b|%b|", a, b, opcode, out, carry, zero);
        end
      end
    end
    $finish;
  end
endmodule
