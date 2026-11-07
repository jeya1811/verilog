// Design Module

module async_fifo #(
  parameter Width= 4,
  parameter Depth= 4
)(
  input wr_clk, rd_clk, rst,
  input wr_en, rd_en,
  input [Width-1:0] in_data,
  output full, empty,
  output reg [Width-1:0] out_data
);
  integer i;
  localparam addr_width= $clog2(Depth);
  localparam ptr_width= addr_width+ 1;
  localparam start_ptr_idx= (1<< (ptr_width- 1))- Depth;
  localparam end_ptr_idx= (1<< (ptr_width- 1))+ Depth- 1;
  localparam gray_start_ptr_idx= start_ptr_idx^ (start_ptr_idx>> 1);
  reg [Width-1:0] mem [0: Depth-1];
  reg [ptr_width-1:0] wr_ptr, rd_ptr;
  wire [ptr_width-1:0] bin_wr_ptr, bin_rd_ptr, bin_wr_ptr_sync, bin_rd_ptr_sync;
  wire [ptr_width-1:0] gray_wr_ptr, gray_rd_ptr, gray_wr_ptr_sync, gray_rd_ptr_sync;
  wire [ptr_width-1:0] wr_ptr_offset, rd_ptr_offset, ptr_offset;
  function reg [addr_width-1:0] mem_addr(
    input [ptr_width-1:0] ptr
  );
    mem_addr= ((ptr- start_ptr_idx)>= Depth)?
                   (ptr- start_ptr_idx)- Depth:
                   (ptr- start_ptr_idx);
  endfunction
  assign bin_wr_ptr= wr_ptr;
  assign bin_rd_ptr= rd_ptr;
  assign wr_ptr_offset= bin_wr_ptr- start_ptr_idx;
  assign rd_ptr_offset= bin_rd_ptr_sync- start_ptr_idx;
  assign ptr_offset= (wr_ptr_offset>= rd_ptr_offset)?
                      wr_ptr_offset- rd_ptr_offset:
                      wr_ptr_offset+ (Depth* 2)- rd_ptr_offset;
  assign full= (ptr_offset== Depth);
  assign empty= (bin_wr_ptr_sync== bin_rd_ptr);
  binary_to_gray #(
    .Width(ptr_width)
  ) u_wr_ptr_bin2gray(
    .in(bin_wr_ptr),
    .out(gray_wr_ptr)
  );
  binary_to_gray #(
    .Width(ptr_width)
  ) u_rd_ptr_bin2gray(
    .in(bin_rd_ptr),
    .out(gray_rd_ptr)
  );
  ff_sync #(
    .Width(ptr_width),
    .Flop_Count(2),
    .Rst_Value(gray_start_ptr_idx)
  ) u_wr_ptr_sync(
    .clk(rd_clk), .rst(rst),
    .in(gray_wr_ptr),
    .out(gray_wr_ptr_sync)
  );
  ff_sync #(
    .Width(ptr_width),
    .Flop_Count(2),
    .Rst_Value(gray_start_ptr_idx)
  ) u_rd_ptr_sync(
    .clk(wr_clk), .rst(rst),
    .in(gray_rd_ptr),
    .out(gray_rd_ptr_sync)
  );
  gray_to_binary #(
    .Width(ptr_width)
  ) u_wr_ptr_gray2bin(
    .in(gray_wr_ptr_sync),
    .out(bin_wr_ptr_sync)
  );
  gray_to_binary #(
    .Width(ptr_width)
  ) u_rd_ptr_gray2bin(
    .in(gray_rd_ptr_sync),
    .out(bin_rd_ptr_sync)
  );
  always @(posedge wr_clk or posedge rst) begin
    if(rst) begin
      wr_ptr<= start_ptr_idx;
      for(i= 0; i< Depth; i+= 1)
        mem[i]<= 'b0;
    end
    else begin
      if(wr_en&& !full) begin
        mem[mem_addr(wr_ptr)]<= in_data;
        wr_ptr<= (wr_ptr== end_ptr_idx)? start_ptr_idx: wr_ptr+ 1;
      end
    end
  end
  always @(posedge rd_clk or posedge rst) begin
    if(rst) begin
      rd_ptr<= start_ptr_idx;
      out_data<= 'b0;
    end
    else begin
      if(rd_en&& !empty) begin
        out_data<= mem[mem_addr(rd_ptr)];
        rd_ptr<= (rd_ptr== end_ptr_idx)? start_ptr_idx:rd_ptr+ 1;
      end
    end
  end
endmodule

module binary_to_gray #(
  parameter Width= 2
)(
  input [Width-1:0] in,
  output [Width-1:0] out
);
  genvar i;
  generate
    for(i= 0; i< Width; i= i+ 1) begin: bin2gray
      if(i== Width-1)
        assign out[i]= in[i];
      else
        assign out[i]= in[i]^ in[i+1];
    end
  endgenerate
endmodule

module gray_to_binary #(
  parameter Width= 2
)(
  input [Width-1:0] in,
  output [Width-1:0] out
);
  genvar i;
  generate
    for(i= 0; i< Width; i= i+ 1) begin: gray2bin
      if(i== Width-1)
        assign out[i]= in[i];
      else
        assign out[i]= in[i]^ out[i+1];
    end
  endgenerate
endmodule

module ff_sync #(
  parameter Width= 2,
  parameter Flop_Count= 2,
  parameter Rst_Value= 0
)(
  input clk, rst,
  input [Width-1:0] in,
  output [Width-1:0] out
);
  integer i;
  reg [Width-1:0] sync [Flop_Count-1:0];
  assign out= sync[Flop_Count-1];
  always @(posedge clk or posedge rst) begin
    if(rst)
      for(i= 0; i< Flop_Count; i+= 1)
        sync[i]<= Rst_Value;
    else begin
      for(i= 0; i< Flop_Count; i+= 1) begin
        if(i== 0)
          sync[i]<= in;
        else
          sync[i]<= sync[i-1];
      end
    end
  end
endmodule

// Testbench Module

`timescale 1ns/1ns
module tb_async_fifo;
  localparam Width= 4;
  localparam Depth= 4;
  reg wr_clk, rd_clk, rst;
  reg wr_en, rd_en;
  reg [Width-1:0] in_data;
  reg done;
  wire full, empty;
  wire [Width-1:0] out_data;
  integer i;
  async_fifo #(
    .Width(Width),
    .Depth(Depth)
  ) dut(
    .wr_clk(wr_clk), .rd_clk(rd_clk), .rst(rst),
    .wr_en(wr_en), .rd_en(rd_en),
    .in_data(in_data),
    .full(full), .empty(empty),
    .out_data(out_data)
  );
  always #5 wr_clk= ~wr_clk;
  always #10 rd_clk= ~rd_clk;
  initial begin
    wr_clk= 1'b0; rd_clk= 1'b0; rst= 1'b1;
    wr_en= 1'b0; rd_en= 1'b0; done= 1'b0; #10;
    rst= 1'b0; #10;
    i= 0;
    while(i< 40) begin
      @(negedge wr_clk) begin
        if(!full) begin
          wr_en= 1'b1;
          in_data= i;
          i+= 1;
        end
        else
          wr_en= 1'b0;
      end
      @(negedge rd_clk)
        rd_en= !empty;
    end
    if(i>= 40) begin
      done= 1'b1;
      wr_en= 1'b0;
    end
    wait(done&& empty);
    #50;
    $finish;
  end
  initial begin
    $dumpfile(".vcd");
    $dumpvars(0, tb_async_fifo);
    $display("Bit Width= %0d, Depth= %0d", Width, Depth);
    $display("|RST|WR_CLK|WR_EN|IN_DATA|FULL|RD_CLK|RD_EN|OUT_DATA|EMPTY|");
    $display("|-|-|-|-|-|-|-|-|-|");
    $monitor("|%b|%b|%b|%b|%b|%b|%b|%b|%b|", rst, wr_clk, wr_en, in_data, full, rd_clk, rd_en, out_data, empty);
  end
endmodule
