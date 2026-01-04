`timescale 1ps/1ps
module tb_encoder4to2;
    reg [3:0] x;
    wire [1:0] y;

encoder_4to1 u_enc4to2(
    .x(x), .y(y)
);

integer i;

initial begin
    $dumpfile("encoder4to2_waves.vcd");
    $dumpvars(0, tb_encoder4to2);
    $display("|X|Y|");
    $display("|-|-|");
    for(i= 0; i< 16; i+= 1)begin
        x= i; #10;
        $display("|%4b|%2b|", x, y);
    end
    $finish;
end
endmodule  

// module tb_priorityencoder4to2;
//     reg [3:0] x;
//     wire [1:0] y;

// priorityencoder_4to2 u_prienc4to2(
//     .x(x), .y(y)
// );

// integer i;
// initial begin
//     $dumpfile("prienc4to2");
//     $dumpvars(0, tb_priorityencoder4to2);
//     $display("|X|Y|");
//     $display("|-|-|"); 
//     for(i= 0; i< 16; i+= 1)begin
//         x= i; #10;
//         $display("|%4b|%2b|", x, y);
//     end
//     $finish;
// end
// endmodule