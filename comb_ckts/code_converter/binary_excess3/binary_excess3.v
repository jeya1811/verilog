// Design Module

module binary_excess3 #(parameter Width= 2)(
  input [Width-1:0] in,
  output [(((Width*1233+4095)/4096)*4)-1:0] out_excess3,
  output [Width-1:0] out_binary
);
binary_to_excess3 #(.Width(Width)) u0(.in(in), .out(out_excess3));
excess3_to_binary #(.Width(Width)) u1(.in(out_excess3), .out(out_binary));
endmodule

module binary_to_excess3 #(parameter Width= 2)(
  input [Width-1:0] in,
  output reg [(((Width*1233+4095)/4096)*4)-1:0] out
);
reg [((((Width*1233+4095)/4096)*4)+Width)-1:0] temp;
integer i, j;
always @(*) begin
  temp= 'b0;
  temp[Width-1:0]= in;
  for(i= 0; i< Width; i+= 1) begin
    for(j= 0; j< ((Width*1233+4095)/4096)*4; j+= 1) begin
      if(temp[Width+j*4+:4]>=5)
        temp[Width+j*4+:4]+= 3;
    end
    temp<<= 1;
  end
  for(i= 0; i< ((Width*1233+4095)/4096)*4; i+= 1)
    temp[Width+i*4+:4]+= 3;
  out= temp[((((Width*1233+4095)/4096)*4)+Width)-1:Width];
end
endmodule

module excess3_to_binary #(parameter Width= 2)(
  input [(((Width*1233+4095)/4096)*4)-1:0] in,
  output reg [Width-1:0] out
);
reg [((((Width*1233+4095)/4096)*4)+Width)-1:0] temp;
integer i, j;
always @(*) begin
  temp= 'b0;
  temp[((((Width*1233+4095)/4096)*4)+Width)-1:Width]= in;
  for(i= 0; i< (Width*1233+4095)/4096; i+= 1)
    temp[Width+i*4+:4]-= 3;
  for(i= 0; i< Width; i+= 1) begin
    temp>>= 1;
    for(j= 0; j< (Width*1233+4095)/4096; j+= 1) begin
      if(temp[Width+j*4+:4]>=8)
        temp[Width+j*4+:4]-= 3;
    end
  end
  out= temp[Width-1:0];
end
endmodule

// Testbench Module

`timescale 1ns/1ns
module tb_binary_excess3;
localparam Width= 4;
reg [Width-1:0] in;
wire [(((Width*1233+4095)/4096)*4)-1:0] out_excess3;
wire [Width-1:0] out_binary;
integer i;

binary_excess3 #(.Width(Width)) dut(.in(in), .out_excess3(out_excess3), .out_binary(out_binary));

initial begin
  for(i= 0; i< 2** Width; i+= 1) begin
    in= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_binary_excess3);
  $display("Bit Width= %0d, Excess3 Width= %0d", Width, (((Width*1233+4095)/4096)*4));
  $display("|TIME|IN|OUT_EXCESS3|OUT_BINARY|");
  $display("|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|", $time, in, out_excess3, out_binary);
end
endmodule
