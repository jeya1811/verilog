// Design Module

module parity_checker #(parameter Width= 2)(
  input [Width-1:0] in_parity_code,
  output out_even_parity_error, out_odd_parity_error
);
even_parity_checker #(.Width(Width)) u_even_parity_checker(.in_parity_code(in_parity_code), .out_error(out_even_parity_error));
odd_parity_checker #(.Width(Width)) u_odd_parity_checker(.in_parity_code(in_parity_code), .out_error(out_odd_parity_error));
endmodule

module even_parity_checker #(parameter Width= 2)(
  input [Width-1:0] in_parity_code,
  output out_error
);
assign out_error= ^in_parity_code;
endmodule

module odd_parity_checker #(parameter Width= 2)(
  input [Width-1:0] in_parity_code,
  output out_error
);
assign out_error= ~^in_parity_code;
endmodule

// Testbench Module

module tb_parity_checker;
localparam Width= 5;
reg [Width-1:0] in_parity_code;
wire out_even_parity_error, out_odd_parity_error;
integer i;

parity_checker #(.Width(Width)) dut(.in_parity_code(in_parity_code), .out_even_parity_error(out_even_parity_error), .out_odd_parity_error(out_odd_parity_error));

initial begin
  for(i= 0; i< 2** Width; i+= 1) begin
    in_parity_code= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_parity_checker);
  $display("Bit Width= %0d", Width);
  $display("|TIME|IN_PARITY_CODE|OUT_EVEN_PARITY_ERROR|OUT_ODD_PARITY_ERROR|");
  $display("|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|", $time, in_parity_code, out_even_parity_error, out_odd_parity_error);
end
endmodule
