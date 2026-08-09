// Design Module

module incrementer #(parameter Width= 1)(
  input [Width-1:0] ip,
  output [Width-1:0] op
);
assign op= ip+ 'b1;
endmodule

// Testbench Module

module tb_incrementer;
localparam Width= 4;
reg [Width-1:0] ip;
wire [Width-1:0] op;
integer i;

incrementer #(.Width(Width)) dut(.ip(ip), .op(op));

initial begin
  for(i= 0; i< 2** Width; i+= 1) begin
    ip= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_incrementer);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IP|OP|");
  $display("|-|-|-|");
  $monitor("|%0t|%b|%b|", $time, ip, op);
end
endmodule
