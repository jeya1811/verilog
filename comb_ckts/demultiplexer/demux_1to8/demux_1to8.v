// Design Module

module demux_1to8 #(parameter Width= 1)(
  input [Width-1:0] ip,
  input [2:0] sel,
  output reg [Width-1:0] op0, op1, op2, op3, op4, op5, op6, op7
);
always @(*) begin
  op0= 'b0;
  op1= 'b0;
  op2= 'b0;
  op3= 'b0;
  op4= 'b0;
  op5= 'b0;
  op6= 'b0;
  op7= 'b0;
  case(sel)
    3'b000: op0= ip;
    3'b001: op1= ip;
    3'b010: op2= ip;
    3'b011: op3= ip;
    3'b100: op4= ip;
    3'b101: op5= ip;
    3'b110: op6= ip;
    3'b111: op7= ip;
  endcase
end
endmodule

// Testbench Module

module tb_demux_1to8;
localparam Width= 2;
reg [Width-1:0] ip;
reg [2:0] sel;
wire [Width-1:0] op0, op1, op2, op3, op4, op5, op6, op7;
integer i;

demux_1to8 #(.Width(Width)) dut(.ip(ip), .sel(sel), .op0(op0), .op1(op1), .op2(op2), .op3(op3), .op4(op4), .op5(op5), .op6(op6), .op7(op7));

initial begin
  for(i= 0; i< 2** (Width+ 3); i+= 1) begin
    {ip, sel}= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_demux_1to8);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IP|SEL|OP0|OP1|OP2|OP3|OP4|OP5|OP6|OP7|");
  $display("|-|-|-|-|-|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|%b|%b|%b|%b|%b|", $time, ip, sel, op0, op1, op2, op3, op4, op5, op6, op7);
end
endmodule
