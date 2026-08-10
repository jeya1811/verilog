// Design Module

module arithmetic_barrel_shifter #(parameter Width= 2, Shift= 1)(
  input signed [Width-1:0] in,
  output signed [Width-1:0] out_signed_left_shift, out_signed_right_shift, out_signed_left_rotate, out_signed_right_rotate
);
signed_left_shift #(.Width(Width), .Shift(Shift)) u_signed_left_shift(.in(in), .out(out_signed_left_shift));
signed_right_shift #(.Width(Width), .Shift(Shift)) u_signed_right_shift(.in(in), .out(out_signed_right_shift));
signed_left_rotate #(.Width(Width), .Shift(Shift)) u_signed_left_rotate(.in(in), .out(out_signed_left_rotate));
signed_right_rotate #(.Width(Width), .Shift(Shift)) u_signed_right_rotate(.in(in), .out(out_signed_right_rotate));
endmodule

module signed_left_shift #(parameter Width= 2, Shift= 1)(
  input signed [Width-1:0] in,
  output signed [Width-1:0] out
);
assign out= in<<< Shift;
endmodule

module signed_right_shift #(parameter Width= 2, Shift= 1)(
  input signed [Width-1:0] in,
  output signed [Width-1:0] out
);
assign out= in>>> Shift;
endmodule

module signed_left_rotate #(parameter Width= 2, Shift= 1)(
  input signed [Width-1:0] in,
  output signed [Width-1:0] out
);
assign out= ($unsigned(in)<< Shift)| ($unsigned(in)>> (Width- Shift));
endmodule

module signed_right_rotate #(parameter Width= 2, Shift= 1)(
  input signed [Width-1:0] in,
  output signed [Width-1:0] out
);
assign out= ($unsigned(in)>> Shift)| ($unsigned(in)<< (Width- Shift));
endmodule

// Testbench Module

module tb_arithmetic_barrel_shifter;
localparam Width= 5, Shift= 2;
reg [Width-1:0] in;
wire [Width-1:0] out_signed_left_shift, out_signed_right_shift, out_signed_left_rotate, out_signed_right_rotate;
integer i;

arithmetic_barrel_shifter #(.Width(Width), .Shift(Shift)) dut(.in(in), .out_signed_left_shift(out_signed_left_shift), .out_signed_right_shift(out_signed_right_shift), .out_signed_left_rotate(out_signed_left_rotate), .out_signed_right_rotate(out_signed_right_rotate));

initial begin
  for(i= 0; i< 2** Width; i+= 1) begin
    in= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_arithmetic_barrel_shifter);
  $display("Bit Width= %0d, Bit Shift= %0d", Width, Shift);
  $display("|TIME|IN|SIGNED_LEFT_SHIFT|SIGNED_RIGHT_SHIFT|SIGNED_LEFT_ROTATE|SIGNED_RIGHT_ROTATE|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, in, out_signed_left_shift, out_signed_right_shift, out_signed_left_rotate, out_signed_right_rotate);
end
endmodule
