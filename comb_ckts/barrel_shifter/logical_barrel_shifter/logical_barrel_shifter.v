// Design Module

module logical_barrel_shifter #(parameter Width= 2, Shift= 1)(
  input [Width-1:0] in,
  output [Width-1:0] out_logical_left_shift, out_logical_right_shift, out_logical_left_rotate, out_logical_right_rotate
);
logical_left_shift #(.Width(Width), .Shift(Shift)) u_logical_left_shift(.in(in), .out(out_logical_left_shift));
logical_right_shift #(.Width(Width), .Shift(Shift)) u_logical_right_shift(.in(in), .out(out_logical_right_shift));
logical_left_rotate #(.Width(Width), .Shift(Shift)) u_logical_left_rotate(.in(in), .out(out_logical_left_rotate));
logical_right_rotate #(.Width(Width), .Shift(Shift)) u_logical_right_rotate(.in(in), .out(out_logical_right_rotate));
endmodule

module logical_left_shift #(parameter Width= 2, Shift= 1)(
  input [Width-1:0] in,
  output [Width-1:0] out
);
assign out= in<< Shift;
endmodule

module logical_right_shift #(parameter Width= 2, Shift= 1)(
  input [Width-1:0] in,
  output [Width-1:0] out
);
assign out= in>> Shift;
endmodule

module logical_left_rotate #(parameter Width= 2, Shift= 1)(
  input [Width-1:0] in,
  output [Width-1:0] out
);
assign out= (in<< Shift)| (in>> (Width- Shift));
endmodule

module logical_right_rotate #(parameter Width= 2, Shift= 1)(
  input [Width-1:0] in,
  output [Width-1:0] out
);
assign out= (in>> Shift)| (in<< (Width- Shift));
endmodule

// Testbench Module

module tb_logical_barrel_shifter;
localparam Width= 5, Shift= 2;
reg [Width-1:0] in;
wire [Width-1:0] out_logical_left_shift, out_logical_right_shift, out_logical_left_rotate, out_logical_right_rotate;
integer i;

logical_barrel_shifter #(.Width(Width), .Shift(Shift)) dut(.in(in), .out_logical_left_shift(out_logical_left_shift), .out_logical_right_shift(out_logical_right_shift), .out_logical_left_rotate(out_logical_left_rotate), .out_logical_right_rotate(out_logical_right_rotate));

initial begin
  for(i= 0; i< 2** Width; i+= 1) begin
    in= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_logical_barrel_shifter);
  $display("Bit Width= %0d, Bit Shift= %0d", Width, Shift);
  $display("|TIME|IN|LOGICAL_LEFT_SHIFT|LOGICAL_RIGHT_SHIFT|LOGICAL_LEFT_ROTATE|LOGICAL_RIGHT_ROTATE|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, in, out_logical_left_shift, out_logical_right_shift, out_logical_left_rotate, out_logical_right_rotate);
end
endmodule
