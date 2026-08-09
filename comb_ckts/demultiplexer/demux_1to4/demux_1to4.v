// Design Module

module demux_1to4 #(parameter Width= 1)(
  input [Width-1:0] ip,
  input [1:0] sel,
  output reg [Width-1:0] op0, op1, op2, op3
);
always @(*) begin
  op0= 'b0;
  op1= 'b0;
  op2= 'b0;
  op3= 'b0;
  case(sel)
    2'b00: op0= ip;
    2'b01: op1= ip;
    2'b10: op2= ip;
    2'b11: op3= ip;
  endcase
end
endmodule

// Testbench Module

module tb_demux_1to4;
localparam Width= 2;
reg [Width-1:0] ip;
reg [1:0] sel;
wire [Width-1:0] op0, op1, op2, op3;
integer i;

demux_1to4 #(.Width(Width)) dut(.ip(ip), .sel(sel), .op0(op0), .op1(op1), .op2(op2), .op3(op3));

initial begin
  for(i= 0; i< 2** (Width+ 2); i+= 1) begin
    {ip, sel}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_demux_1to4);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IP|SEL|OP0|OP1|OP2|OP3|");
  $display("|-|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|%b|", $time, ip, sel, op0, op1, op2, op3);
end
endmodule
