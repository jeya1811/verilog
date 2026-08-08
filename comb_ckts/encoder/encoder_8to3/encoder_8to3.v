// Design Module

module encoder_8to3(
  input [7:0] data,
  output reg [2:0] out
);
always @(*) begin
  case(data)
    8'b00000001: out= 3'b000;
    8'b00000010: out= 3'b001;
    8'b00000100: out= 3'b010;
    8'b00001000: out= 3'b011;
    8'b00010000: out= 3'b100;
    8'b00100000: out= 3'b101;
    8'b01000000: out= 3'b110;
    8'b10000000: out= 3'b111;
    default: out= 'bx;
  endcase
end
endmodule

// Testbench Module

module tb_encoder_8to3;
reg [7:0] data;
wire [2:0] out;
integer i;

encoder_8to3 dut(.data(data), .out(out));

initial begin
  for(i= 0; i< 2** 8; i+= 1) begin
    data= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_encoder_8to3);
  $display("|TIME|DATA|OUT|");
  $display("|-|-|-|");
  $monitor("|%0t|%b|%b|", $time, data, out);
end
endmodule
