// Design Module

module signed_barrel_shifter #(parameter Width= 2, Shift= 1)(
  input signed [Width-1:0] ip,
  output signed [Width-1:0] op_signed_left_shift, op_signed_right_shift, op_signed_left_rotate, op_signed_right_rotate
);
signed_left_shift #(.Width(Width), .Shift(Shift)) u_signed_left_shift(.ip(ip), .op(op_signed_left_shift));
signed_right_shift #(.Width(Width), .Shift(Shift)) u_signed_right_shift(.ip(ip), .op(op_signed_right_shift));
signed_left_rotate #(.Width(Width), .Shift(Shift)) u_signed_left_rotate(.ip(ip), .op(op_signed_left_rotate));
signed_right_rotate #(.Width(Width), .Shift(Shift)) u_signed_right_rotate(.ip(ip), .op(op_signed_right_rotate));
endmodule

module signed_left_shift #(parameter Width= 2, Shift= 1)(
  input signed [Width-1:0] ip,
  output signed [Width-1:0] op
);
assign op= ip<<< Shift;
endmodule

module signed_right_shift #(parameter Width= 2, Shift= 1)(
  input signed [Width-1:0] ip,
  output signed [Width-1:0] op
);
assign op= ip>>> Shift;
endmodule

module signed_left_rotate #(parameter Width= 2, Shift= 1)(
  input signed [Width-1:0] ip,
  output signed [Width-1:0] op
);
assign op= ($unsigned(ip)<< Shift)| ($unsigned(ip)>> (Width- Shift));
endmodule

module signed_right_rotate #(parameter Width= 2, Shift= 1)(
  input signed [Width-1:0] ip,
  output signed [Width-1:0] op
);
assign op= ($unsigned(ip)>> Shift)| ($unsigned(ip)<< (Width- Shift));
endmodule

// Testbench Module

module tb_signed_barrel_shifter;
localparam Width= 5, Shift= 2;
reg [Width-1:0] ip;
wire [Width-1:0] op_signed_left_shift, op_signed_right_shift, op_signed_left_rotate, op_signed_right_rotate;
integer i;

signed_barrel_shifter #(.Width(Width), .Shift(Shift)) dut(.ip(ip), .op_signed_left_shift(op_signed_left_shift), .op_signed_right_shift(op_signed_right_shift), .op_signed_left_rotate(op_signed_left_rotate), .op_signed_right_rotate(op_signed_right_rotate));

initial begin
  for(i= 0; i< 2** Width; i+= 1) begin
    ip= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_signed_barrel_shifter);
  $display("Bit Width= %0d, Bit Shift= %0d", Width, Shift);
  $display("|TIME|IP|SIGNED_LEFT_SHIFT|SIGNED_RIGHT_SHIFT|SIGNED_LEFT_ROTATE|SIGNED_RIGHT_ROTATE|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, ip, op_signed_left_shift, op_signed_right_shift, op_signed_left_rotate, op_signed_right_rotate);
end
endmodule
