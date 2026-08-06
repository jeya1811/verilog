// Design Module

module full_subtractor(
  input a, b, bin,
  output diff, borrow
);
assign diff= a^ b^ bin;
assign borrow= (~a& b)| ((a~^ b)& bin);
endmodule

// Testbench Module

module tb;
reg a, b, bin;
wire diff, borrow;
integer i;

full_subtractor dut(.a(a), .b(b), .bin(bin), .diff(diff), .borrow(borrow));

initial begin
  for(i= 0; i< 8; i+= 1) begin
    {a, b, bin}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb);
  $display("|TIME|A|B|Bin|DIFF|BORROW|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, a, b, bin, diff, borrow);
end
endmodule
