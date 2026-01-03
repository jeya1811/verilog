module encoder_4to1(
    input [3:0] x,
    output reg [1:0] y
);
    always @(*) begin
        case(x)
        4'b0001: y= 2'b00;
        4'b0010: y= 2'b01;
        4'b0100: y= 2'b10;
        4'b1000: y= 2'b11;
        default: y= 2'b00;
        endcase
    end
endmodule

module priorityencoder_4to2(
    input [3:0] x,
    output reg [1:0] y
);
    always @(*) begin
        if(x[3]) y= 2'b11;
        else if(x[2]) y= 2'b10;
        else if(x[1]) y= 2'b01;
        else if(x[0]) y= 2'b00;
        else y= 2'b00;
    end
endmodule


