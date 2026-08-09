// Design Module

module parity_generator #(parameter Width= 2)(
  input [Width-1:0] ip,
  output [Width:0] op_even_parity_code, op_odd_parity_code
);
even_parity_generator #(.Width(Width)) u_even_parity_generator(.ip(ip), .op(op_even_parity_code));
odd_parity_generator #(.Width(Width)) u_odd_parity_generator(.ip(ip), .op(op_odd_parity_code));
endmodule

module even_parity_generator #(parameter Width= 2)(
  input [Width-1:0] ip,
  output [Width:0] op
);
wire parity_bit;
assign parity_bit= ^ip;
assign op= {ip, parity_bit};
endmodule

module odd_parity_generator #(parameter Width= 2)(
  input [Width-1:0] ip,
  output [Width:0] op
);
wire parity_bit;
assign parity_bit= ~^ip;
assign op= {ip, parity_bit};
endmodule

// Testbench Module

module tb_parity_generator;
localparam Width= 4;
reg [Width-1:0] ip;
wire [Width:0] op_even_parity_code, op_odd_parity_code;
integer i;

parity_generator #(.Width(Width)) dut(.ip(ip), .op_even_parity_code(op_even_parity_code), .op_odd_parity_code(op_odd_parity_code));

initial begin
  for(i= 0; i< 2** Width; i+= 1) begin
    ip= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_parity_generator);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IP|EVEN_PARITY_CODE|ODD_PARITY_CODE|");
  $display("|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|", $time, ip, op_even_parity_code, op_odd_parity_code);
end
endmodule
