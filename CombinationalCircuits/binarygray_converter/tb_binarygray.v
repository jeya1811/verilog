`timescale 1ps/1ps

module tb_binarygray;
reg [3:0] x;
wire [3:0] y, z;

binarytogray u_binarytogray(
    .x(x), .y(y)
);

graytobinary u_graytobinary(
    .x(y), .y(z)
);

integer i;

initial begin
    $dumpfile("binarygray_waves.vcd");
    $dumpvars(0, tb_binarygray);
    $display("|Binary|Gray|Binary|");
    $display("|-|-|-|");
    for(i= 0; i< 16; i+= 1)begin
        x= i; #10;
        $display("|%4b|%4b|%4b|", x, y, z);
    end
    $finish;
end
endmodule