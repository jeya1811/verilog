module binarytoBCD(
    input [7:0] binary, 
    output reg [3:0] bcd_tens,
    output reg [3:0] bcd_ones
);
reg [3:0] tens;
reg [3:0] ones;
reg [7:0] bin;
integer i;
always @(*) begin
    tens= 4'b0000;
    ones= 4'b0000;
    bin= binary;

    for(i= 7; i>= 0; i--)begin
        if(tens>= 5)
            tens+= 3;
        if (ones>= 5)
            ones+= 3;

        {tens, ones}= {tens, ones}<< 1;
        ones[0]= bin[i];
    end
    
    bcd_tens= tens;
    bcd_ones= ones;
end
endmodule

module BCDto7segment(
    input [3:0] BCD,
    output reg [6:0] seg
);
always @(*) begin
    case(BCD)
                    //abcdefg
        4'b0000: seg= 7'b1111110;
        4'b0001: seg= 7'b0110000;
        4'b0010: seg= 7'b1101101;
        4'b0011: seg= 7'b1111001;
        4'b0100: seg= 7'b0110011;
        4'b0101: seg= 7'b1011011;
        4'b0110: seg= 7'b1011111;
        4'b0111: seg= 7'b1110000;
        4'b1000: seg= 7'b1111111;
        4'b1001: seg= 7'b1111011;
        default: seg= 7'b0000000;
    endcase
end
endmodule
