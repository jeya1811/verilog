// Design Module

module priority_encoder_2to1(
  input [1:0] data,
  output reg out
);
always @(*) begin
  casez(data)
    2'b1?: out= 'b1;
    2'b01: out= 'b0;
    default: out= 'bx;
  endcase
end
endmodule

// Testbench Module

module tb_priority_encoder_2to1;
reg [1:0] data;
wire out;
integer i;

priority_encoder_2to1 dut(.data(data), .out(out));

initial begin
  for(i= 0; i< 2** 2; i+= 1) begin
    data= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_priority_encoder_2to1);
  $display("|TIME|DATA|OUT|");
  $display("|-|-|-|");
  $monitor("|%0t|%b|%b|", $time, data, out);
end
endmodule
