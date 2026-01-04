module binarytoBCD(
    input [7:0] x, 
    output reg [3:0] tens,
    output reg [3:0] ones
);
reg [3:0] bcd_tens;
reg [3:0] bcd_ones;
reg [7:0] bin;
integer i;
always @(*) begin
    bcd_tens= 4'b0000;
    bcd_ones= 4'b0000;
    bin= x;

    for(i= 7; i>= 0; i--)begin
        if(bcd_tens>= 5)
            bcd_tens+= 3;
        if(bcd_ones>= 5)
            bcd_ones+= 3;

        {bcd_tens, bcd_ones}= {bcd_tens, bcd_ones}<< 1;
        bcd_ones[0]= bin[i];
    end
    
    tens= bcd_tens;
    ones= bcd_ones;
end
endmodule