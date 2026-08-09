// Design Module

module mux_4to1 #(parameter Width= 1)(
  input [Width-1:0] ip0, ip1, ip2, ip3,
  input [1:0] sel,
  output reg [Width-1:0] op
);
always @(*) begin
  case(sel)
    2'b00: op= ip0;
    2'b01: op= ip1;
    2'b10: op= ip2;
    2'b11: op= ip3;
    default: op= 'b0;
  endcase
end
endmodule

// Testbench Module

module tb_mux_4to1;
localparam Width= 1;
reg [Width-1:0] ip0, ip1, ip2, ip3;
reg [1:0] sel;
wire [Width-1:0] op;
integer i;

mux_4to1 #(.Width(Width)) dut(.ip0(ip0), .ip1(ip1), .ip2(ip2), .ip3(ip3), .sel(sel), .op(op));

initial begin
  for(i= 0; i< 2** (4* Width+ 2); i+= 1) begin
    {ip0, ip1, ip2, ip3, sel}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_mux_4to1);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IP0|IP1|IP2|IP3|SEL|OP|");
  $display("|-|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|%b|", $time, ip0, ip1, ip2, ip3, sel, op);
end
endmodule
