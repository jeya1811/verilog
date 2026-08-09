// Design Module

module unsigned_barrel_shifter #(parameter Width= 2, Shift= 1)(
  input [Width-1:0] ip,
  output [Width-1:0] op_unsigned_left_shift, op_unsigned_right_shift, op_unsigned_left_rotate, op_unsigned_right_rotate
);
unsigned_left_shift #(.Width(Width), .Shift(Shift)) u_unsigned_left_shift(.ip(ip), .op(op_unsigned_left_shift));
unsigned_right_shift #(.Width(Width), .Shift(Shift)) u_unsigned_right_shift(.ip(ip), .op(op_unsigned_right_shift));
unsigned_left_rotate #(.Width(Width), .Shift(Shift)) u_unsigned_left_rotate(.ip(ip), .op(op_unsigned_left_rotate));
unsigned_right_rotate #(.Width(Width), .Shift(Shift)) u_unsigned_right_rotate(.ip(ip), .op(op_unsigned_right_rotate));
endmodule

module unsigned_left_shift #(parameter Width= 2, Shift= 1)(
  input [Width-1:0] ip,
  output [Width-1:0] op
);
assign op= ip<< Shift;
endmodule

module unsigned_right_shift #(parameter Width= 2, Shift= 1)(
  input [Width-1:0] ip,
  output [Width-1:0] op
);
assign op= ip>> Shift;
endmodule

module unsigned_left_rotate #(parameter Width= 2, Shift= 1)(
  input [Width-1:0] ip,
  output [Width-1:0] op
);
assign op= (ip<< Shift)| (ip>> (Width- Shift));
endmodule

module unsigned_right_rotate #(parameter Width= 2, Shift= 1)(
  input [Width-1:0] ip,
  output [Width-1:0] op
);
assign op= (ip>> Shift)| (ip<< (Width- Shift));
endmodule

// Testbench Module

module tb_unsigned_barrel_shifter;
localparam Width= 3, Shift= 1;
reg [Width-1:0] ip;
wire [Width-1:0] op_unsigned_left_shift, op_unsigned_right_shift, op_unsigned_left_rotate, op_unsigned_right_rotate;
integer i;

unsigned_barrel_shifter #(.Width(Width), .Shift(Shift)) dut(.ip(ip), .op_unsigned_left_shift(op_unsigned_left_shift), .op_unsigned_right_shift(op_unsigned_right_shift), .op_unsigned_left_rotate(op_unsigned_left_rotate), .op_unsigned_right_rotate(op_unsigned_right_rotate));

initial begin
  for(i= 0; i< 2** Width; i+= 1) begin
    ip= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_unsigned_barrel_shifter);
  $display("Bit Width= %0d, Bit Shift= %0d", Width, Shift);
  $display("|TIME|IP|UNSIGNED_LEFT_SHIFT|UNSIGNED_RIGHT_SHIFT|UNSIGNED_LEFT_ROTATE|UNSIGNED_RIGHT_ROTATE|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, ip, op_unsigned_left_shift, op_unsigned_right_shift, op_unsigned_left_rotate, op_unsigned_right_rotate);
end
endmodule
