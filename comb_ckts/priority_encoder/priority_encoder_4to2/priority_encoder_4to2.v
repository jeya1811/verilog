// Design Module

module priority_encoder_4to2(
  input [3:0] data,
  output reg [1:0] out
);
always @(*) begin
  casez(data)
    4'b1???: out= 2'b11;
    4'b01??: out= 2'b10;
    4'b001?: out= 2'b01;
    4'b0001: out= 2'b00;
    default: out= 'bx;
  endcase
end
endmodule

// Testbench Module

module tb_priority_encoder_4to2;
reg [3:0] data;
wire [1:0] out;
integer i;

priority_encoder_4to2 dut(.data(data), .out(out));

initial begin
  for(i= 0; i< 2** 4; i+= 1) begin
    data = i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_priority_encoder_4to2);
  $display("|TIME|DATA|OUT|");
  $display("|-|-|-|");
  $monitor("|%0t|%b|%b|", $time, data, out);
end
endmodule
