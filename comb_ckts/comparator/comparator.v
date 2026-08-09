// Design Module

module comparator #(parameter Width= 1)(
  input [Width-1:0] ip0, ip1,
  output op_gt, op_eq, op_lt
);
assign op_gt= ip0> ip1;
assign op_eq= ip0== ip1;
assign op_lt= ip0< ip1;
endmodule

// Testbench Module

module tb_comparator;
localparam Width= 2;
reg [Width-1:0] ip0, ip1;
wire op_gt, op_eq, op_lt;
integer i;

comparator #(.Width(Width)) dut(.ip0(ip0), .ip1(ip1), .op_gt(op_gt), .op_eq(op_eq), .op_lt(op_lt));

initial begin
  for(i= 0; i< 2** (2* Width); i+= 1) begin
    {ip0, ip1}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_comparator);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IP1|IP2|GT|EQ|LT|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, ip0, ip1, op_gt, op_eq, op_lt);
end
endmodule
