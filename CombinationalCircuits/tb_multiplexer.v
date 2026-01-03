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
//     $display("A1  A2   sel   y");
//     for(integer i= 0; i< 4; i+= 1)begin
//         a= i; sel= 0; #10;
//         $display("%d  %d  %d  %d", a[1], a[0], sel, y);
//         a= i; sel= 1; #10;
//         $display("%d  %d  %d  %d", a[1], a[0], sel, y);
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
    $display("A1 A2 A3 A4   SEL1 SEL2  OP");
    for(i= 0; i< 16; i+= 1)begin
        for(j= 0; j< 4; j+= 1)begin
            a= i; sel= j; #10;
            $display("%d  %d  %d  %d    %d  %d     %d", a[3], a[2], a[1], a[0], sel[1], sel[0], y);
        end
    end
    $finish;
end
endmodule


