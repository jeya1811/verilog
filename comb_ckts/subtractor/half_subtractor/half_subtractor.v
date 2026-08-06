// Design Module

module half_subtractor(
  input a, b,
  output diff, borrow
);
assign diff= a^ b;
assign borrow= ~a& b;
endmodule

// Testbench Module

module tb;
reg a, b;
wire diff, borrow;
integer i;

half_subtractor dut(.a(a), .b(b), .diff(diff), .borrow(borrow));

initial begin
  for(i= 0; i< 4; i+= 1) begin
    {a, b}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb);
  $display("|TIME|A|B|DIFF|BORROW|");
  $display("|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|", $time, a, b, diff, borrow);
end
endmodule
