// Design Module

module priority_encoder_8to3(
  input [7:0] data,
  output reg [2:0] out
);
always @(*) begin
  casez(data)
    8'b1???????: out= 3'b111;
    8'b01??????: out= 3'b110;
    8'b001?????: out= 3'b101;
    8'b0001????: out= 3'b100;
    8'b00001???: out= 3'b011;
    8'b000001??: out= 3'b010;
    8'b0000001?: out= 3'b001;
    8'b00000001: out= 3'b000;
    default: out= 'bx;
  endcase
end
endmodule

// Testbench Module

module tb;
reg [7:0] data;
wire [2:0] out;
integer i;

priority_encoder_8to3 dut(.data(data), .out(out));

initial begin
  for(i= 0; i< 2** 8; i+= 1) begin
    data= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb);
  $display("|TIME|DATA|OUT|");
  $display("|-|-|-|");
  $monitor("|%0t|%b|%b|", $time, data, out);
end
endmodule
