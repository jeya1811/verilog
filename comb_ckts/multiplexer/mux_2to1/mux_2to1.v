// Design Module

module mux_2to1 #(parameter Width= 1)(
  input [Width-1:0] ip0, ip1,
  input sel,
  output [Width-1:0] op
);
assign op= sel? ip1: ip0;
endmodule

// Testbench Module

module tb_mux_2to1;
localparam Width= 1;
reg [Width-1:0] ip0, ip1;
reg sel;
wire [Width-1:0] op;
integer i;

mux_2to1 #(.Width(Width)) dut(.ip0(ip0), .ip1(ip1), .sel(sel), .op(op));

initial begin
  for(i= 0; i< 2** (2* Width+ 1); i+= 1) begin
    {ip0, ip1, sel}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_mux_2to1);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IP0|IP1|SEL|OP|");
  $display("|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|", $time, ip0, ip1, sel, op);
end
endmodule
