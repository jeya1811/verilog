// Design Module

module mux_8to1 #(parameter Width= 1)(
  input [Width-1:0] ip0, ip1, ip2, ip3, ip4, ip5, ip6, ip7,
  input [2:0] sel,
  output reg [Width-1:0] op
);
always @(*) begin
  case(sel)
    3'b000: op= ip0;
    3'b001: op= ip1;
    3'b010: op= ip2;
    3'b011: op= ip3;
    3'b100: op= ip4;
    3'b101: op= ip5;
    3'b110: op= ip6;
    3'b111: op= ip7;
    default: op= 'b0;
  endcase
end
endmodule

// Testbench Module

module tb_mux_8to1;
localparam Width= 1;
reg [Width-1:0] ip0, ip1, ip2, ip3, ip4, ip5, ip6, ip7;
reg [2:0] sel;
wire [Width-1:0] op;
integer i;

mux_8to1 #(.Width(Width)) dut(.ip0(ip0), .ip1(ip1), .ip2(ip2), .ip3(ip3), .ip4(ip4), .ip5(ip5), .ip6(ip6), .ip7(ip7), .sel(sel), .op(op));

initial begin
  for(i= 0; i< 2** (8* Width+ 4); i+= 1) begin
    {ip0, ip1, ip2, ip3, ip4, ip5, ip6, ip7, sel}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_mux_8to1);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IP0|IP1|IP2|IP3|IP4|IP5|IP6|IP7|SEL|OP|");
  $display("|-|-|-|-|-|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|%b|%b|%b|%b|%b|", $time, ip0, ip1, ip2, ip3, ip4, ip5, ip6, ip7, sel, op);
end
endmodule
