`timescale 1ps/1ps
// module tb_mux2to1;
//     reg [1:0] a;
//     reg sel;  
//     wire y;

// mux_2to1 u_mux2to1(
//     .a(a), .sel(sel), .y(y)
// );

// initial begin
//     $dumpfile("mux2to1_waves.vcd");
//     $dumpvars(0, tb_mux2to1);
//     $display("|INPUT|SEL|OUTPUT");
//     $display("|-|-|-|"); 
//     for(integer i= 0; i< 4; i+= 1)begin
//         a= i; sel= 0; #10;
//         $display("|%2b|%b|%b|, a, sel, y);
//         a= i; sel= 1; #10;
//         $display("|%2b|%b|%b|, a, sel, y);
//     end
//     $finish;
// end
// endmodule

module tb_mux4to1;
    reg [3:0] a;
    reg [1:0] sel;
    wire y;

mux_4to1 u_mux4to1(
    .a(a), .sel(sel), .y(y)
);
integer i, j;

initial begin
    $dumpfile("mux4to1_waves");
    $dumpvars(0, tb_mux4to1);
    $display("|INPUT|SEL|OUTPUT|");
    $display("|-|-|-|");
    for(i= 0; i< 16; i+= 1)begin
        for(j= 0; j< 4; j+= 1)begin
            a= i; sel= j; #10;
            $display("|%4b|%2b|%b|", a, sel, y);
        end
    end
    $finish;
end
endmodule


