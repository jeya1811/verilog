// Design Module

module seq_det_1101(
  input clk, rst, in,
  output out_non_overlap, out_overlap
);
seq_det_non_overlap u0(.clk(clk), .rst(rst), .in(in), .out(out_non_overlap));
seq_det_overlap u1(.clk(clk), .rst(rst), .in(in), .out(out_overlap));
endmodule

module seq_det_non_overlap(
  input clk, rst, in,
  output reg out
);
localparam [1:0] S0= 2'd0, S1= 2'd1, S2= 2'd2, S3= 2'd3;
reg [1:0] state, next_state;
always @(posedge clk or posedge rst) begin
  if(rst)
    state<= S0;
  else
    state<= next_state;
end

always @(*) begin
  case(state)
    S0: next_state= in? S1: S0;
    S1: next_state= in? S2: S0;
    S2: next_state= in? S1: S3;
    S3: next_state= S0;
    default: next_state= S0;
  endcase
end

always @(*) begin
  case(state)
    S3: out= in? 1'b1: 1'b0;
    default: out= 1'b0;
  endcase
end
endmodule

module seq_det_overlap(
  input clk, rst, in,
  output reg out
);
localparam [1:0] S0= 2'd0, S1= 2'd1, S2= 2'd2, S3= 2'd3;
reg [1:0] state, next_state;
always @(posedge clk or posedge rst) begin
  if(rst)
    state<= S0;
  else
    state<= next_state;
end

always @(*) begin
  case(state)
    S0: next_state= in? S1: S0;
    S1: next_state= in? S2: S0;
    S2: next_state= in? S1: S3;
    S3: next_state= in? S1: S0;
    default: next_state= S0;
  endcase
end

always @(*) begin
  case(state)
    S3: out= in? 1'b1: 1'b0;
    default: out= 1'b0;
  endcase
end
endmodule

// Testbench Module

module tb_seq_det_1101;
reg clk= 1'b0;
reg rst= 1'b1;
reg [7:0] in_seq= 8'b11011011;
reg in;
wire out_non_overlap, out_overlap;
integer i;

seq_det_1101 dut(.clk(clk), .rst(rst), .in(in), .out_non_overlap(out_non_overlap), .out_overlap(out_overlap));

always #5 clk= ~clk;

initial begin
  #10; rst= 1'b0;
  for(i= 0; i< 8; i+= 1) begin
    in= in_seq[i]; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_seq_det_1101);
  $display("TIME|CLK|RST|IN|OUT_NON_OVERLAP|OUT_OVERLAP|");
  $display("|-|-|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|%b|%b|", $time, clk, rst, in, out_non_overlap, out_overlap);
end
endmodule
