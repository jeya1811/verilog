module full_subtractor(
    input a, b, borrow_in,
    output diff, borrow_out
);
    assign diff= a ^ b ^ borrow_in;
    assign borrow_out= (~a & b) | ((~a | b) & borrow_in);
endmodule