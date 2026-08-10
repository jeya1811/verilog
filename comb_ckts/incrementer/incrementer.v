// Design Module

module incrementer #(parameter Width= 1)(
  input [Width-1:0] in,
  output [Width-1:0] out
);
assign out= in+ 'b1;
endmodule

// Testbench Module

module tb_incrementer;
localparam Width= 4;
reg [Width-1:0] in;
wire [Width-1:0] out;
integer i;

incrementer #(.Width(Width)) dut(.in(in), .out(out));

initial begin
  for(i= 0; i< 2** Width; i+= 1) begin
    in= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_incrementer);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IN|OUT|");
  $display("|-|-|-|");
  $monitor("|%0t|%b|%b|", $time, in, out);
end
endmodule
