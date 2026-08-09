// Design Module

module demux_1to2 #(parameter Width= 1)(
  input [Width-1:0] ip,
  input sel,
  output [Width-1:0] op0, op1
);
assign op0= sel? 'b0: ip;
assign op1= sel? ip: 'b0;
endmodule

// Testbench Module

module tb_demux_1to2;
localparam Width= 2;
reg [Width-1:0] ip;
reg sel;
wire [Width-1:0] op0, op1;
integer i;

demux_1to2 #(.Width(Width)) dut(.ip(ip), .sel(sel), .op0(op0), .op1(op1));

initial begin
  for(i= 0; i< 2** (Width+ 1); i+= 1) begin
    {ip, sel}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_demux_1to2);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IP|SEL|OP0|OP1|");
  $display("|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|", $time, ip, sel, op0, op1);
end
endmodule
