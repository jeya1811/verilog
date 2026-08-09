// Design Module

module parity_detector #(parameter Width= 2)(
  input [Width-1:0] parity_code,
  output op_even_parity_error, op_odd_parity_error
);
even_parity_detector #(.Width(Width)) u_even_parity_detector(.parity_code(parity_code), .error(op_even_parity_error));
odd_parity_detector #(.Width(Width)) u_odd_parity_detector(.parity_code(parity_code), .error(op_odd_parity_error));
endmodule

module even_parity_detector #(parameter Width= 2)(
  input [Width-1:0] parity_code,
  output error
);
assign error= ^parity_code;
endmodule

module odd_parity_detector #(parameter Width= 2)(
  input [Width-1:0] parity_code,
  output error
);
assign error= ~^parity_code;
endmodule

// Testbench Module

module tb_parity_detector;
localparam Width= 5;
reg [Width-1:0] parity_code;
wire op_even_parity_error, op_odd_parity_error;
integer i;

parity_detector #(.Width(Width)) dut(.parity_code(parity_code), .op_even_parity_error(op_even_parity_error), .op_odd_parity_error(op_odd_parity_error));

initial begin
  for(i= 0; i< 2** Width; i+= 1) begin
    parity_code= i; #10;
  end
  $finish;
end

initial begin
  $dumpfile(".vcd");
  $dumpvars(0, tb_parity_detector);
  $display("Bit Width= %0d", Width);
  $display("|TIME|PARITY_CODE|op_even_parity_error|op_odd_parity_error|");
  $display("|-|-|-|-|");
  $monitor("|%0t|%b|%b|%b|", $time, parity_code, op_even_parity_error, op_odd_parity_error);
end
endmodule
