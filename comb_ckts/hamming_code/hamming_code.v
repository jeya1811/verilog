// Design Module

module hamming_code #(
  parameter Width= 4,
  parameter Parity= 0
)(
  input [Width-1:0] in_data,
  output [(Width+$clog2(Width+$clog2(Width+1)+1)):0] out_code,
  output [Width-1:0] out_data,
  output [1:0] out_error
);
  hamming_encoder #(
    .Width(Width),
    .Parity(Parity)
  ) u_hamming_encoder(
    .in_data(in_data),
    .out_code(out_code)
  );
  hamming_decoder #(
    .Width(Width),
    .Parity(Parity)
  ) u_hamming_decoder(
    .in_code(out_code),
    .out_data(out_data),
    .out_error(out_error)
  );
endmodule

module hamming_encoder #(
  parameter Width= 4,
  parameter Parity= 0
)(
  input [Width-1:0] in_data,
  output reg [(Width+$clog2(Width+$clog2(Width+1)+1)):0] out_code
);
  localparam Parity_Width= $clog2(Width+ $clog2(Width+ 1)+ 1);
  localparam Code_Width= Width+ Parity_Width;
  reg [Code_Width:1] code;
  reg overall_parity;
  integer pos;
  integer data_idx, parity_idx;
  always @(*) begin
    data_idx= 0;
    code= 'b0;
    for(pos= 1; pos<= Code_Width; pos+= 1) begin
      if((pos& (pos- 1))!= 0) begin
        code[pos]= in_data[data_idx];
        data_idx+= 1;
      end
      else
        code[pos]= Parity;
    end
    for(parity_idx= 0; parity_idx< Parity_Width; parity_idx+= 1) begin
      for(pos= 1; pos<= Code_Width; pos+= 1) begin
        if(((pos>> parity_idx)& 1)&& (pos!= (1<< parity_idx)))
          code[1<< parity_idx]= code[1<< parity_idx]^ code[pos];
      end
    end
    overall_parity= Parity^ (^code);
    out_code= {overall_parity, code};
  end
endmodule

module hamming_decoder #(
  parameter Width= 4,
  parameter Parity= 0
)(
  input [(Width+$clog2(Width+$clog2(Width+1)+1)):0] in_code,
  output reg [Width-1:0] out_data,
  output reg [1:0] out_error
);
  localparam Syndrome_Width= $clog2(Width+ $clog2(Width+ 1)+ 1);
  localparam Code_Width= Width+ Syndrome_Width;
  reg [Code_Width:1] code;
  reg [Syndrome_Width-1:0] syndrome;
  reg overall_syndrome;
  integer pos;
  integer data_idx, syndrome_idx;
  always @(*) begin
    data_idx= 0;
    out_error= 'b0;
    syndrome= 'b0;
    code= in_code[Code_Width-1:0];
    overall_syndrome= Parity^ (^in_code);
    for(syndrome_idx= 0; syndrome_idx< Syndrome_Width; syndrome_idx+= 1) begin
      syndrome[syndrome_idx]= Parity;
      for(pos= 1; pos<= Code_Width; pos+= 1) begin
        if((pos>> syndrome_idx)& 1)
          syndrome[syndrome_idx]= syndrome[syndrome_idx]^ code[pos];
      end
    end
    if(syndrome) begin
      if(overall_syndrome&& syndrome<= Code_Width) begin
        code[syndrome]= ~code[syndrome];
        out_error= 'b01;
      end
      else begin
        out_error= 'b10;
      end
    end
    else begin
      if(overall_syndrome)
        out_error= 'b01;
      else
        out_error= 'b00;
    end
    if(out_error< 2) begin
      for(pos= 1; pos<= Code_Width; pos+= 1) begin
        if((pos& (pos- 1))!= 0) begin
          out_data[data_idx]= code[pos];
          data_idx+= 1;
        end
      end
    end
    else
      out_data= 'bx;
  end
endmodule

// Testbench Module

`timescale 1ns/1ns
module tb_hamming_code;
  localparam Width= 4;
  localparam Parity= 1;
  reg [Width-1:0] in_data;
  wire [(Width+$clog2(Width+$clog2(Width+1)+1)):0] out_code;
  wire [Width-1:0] out_data;
  wire [1:0] out_error;
  integer i;
  hamming_code #(
    .Width(Width),
    .Parity(Parity)
  ) dut(
    .in_data(in_data),
    .out_code(out_code),
    .out_data(out_data),
    .out_error(out_error)
  );
  initial begin
    for(i= 0; i< 2** Width; i+= 1) begin
      in_data= i; #10;
    end
    $finish;
  end
  initial begin
    $dumpfile(".vcd");
    $dumpvars(0, tb_hamming_code);
    $display("Bit Width= %0d and Parity= %0s", Width, Parity? "odd": "even");
    $display("|TIME|IN_DATA|OUT_CODE|OUT_DATA|OUT_ERROR|");
    $display("|-|-|-|-|-|");
    $monitor("|%0t|%b|%b|%b|%d|", $time, in_data, out_code, out_data, out_error);
  end
endmodule
