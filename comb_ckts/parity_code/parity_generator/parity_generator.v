// Design Module

module parity_generator #(parameter Width= 2)(
  input [Width-1:0] in,
  output [Width:0] out_even_parity_code, out_odd_parity_code
);
even_parity_generator #(.Width(Width)) u_even_parity_generator(.in(in), .out(out_even_parity_code));
odd_parity_generator #(.Width(Width)) u_odd_parity_generator(.in(in), .out(out_odd_parity_code));
endmodule

module even_parity_generator #(parameter Width= 2)(
  input [Width-1:0] in,
  output [Width:0] out
);
wire parity_bit;
assign parity_bit= ^in;
assign out= {in, parity_bit};
endmodule

module odd_parity_generator #(parameter Width= 2)(
  input [Width-1:0] in,
  output [Width:0] out
);
wire parity_bit;
assign parity_bit= ~^in;
assign out= {in, parity_bit};
endmodule

// Testbench Module

module tb_parity_generator;
localparam Width= 4;
reg [Width-1:0] in;
wire [Width:0] out_even_parity_code, out_odd_parity_code;
integer i;

parity_generator #(.Width(Width)) dut(.in(in), .out_even_parity_code(out_even_parity_code), .out_odd_parity_code(out_odd_parity_code));

initial begin
  for(i= 0; i< 2** Width; i+= 1) begin
    in= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_parity_generator);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IN|EVEN_PARITY_CODE|ODD_PARITY_CODE|");
  $display("|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|", $time, in, out_even_parity_code, out_odd_parity_code);
end
endmodule
