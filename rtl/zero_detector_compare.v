module zero_detector_eq (
    input  wire [31:0] data,
    output wire zero
);
    assign zero = (data == 32'b0);
endmodule


module zero_detector_tree (
    input  wire [31:0] data,
    output wire zero
);
    wire [15:0] level1;
    wire [7:0]  level2;
    wire [3:0]  level3;
    wire [1:0]  level4;
    wire        level5;

    genvar i;

    generate
        for (i = 0; i < 16; i = i + 1) begin
            assign level1[i] = data[2*i] | data[2*i+1];
        end

        for (i = 0; i < 8; i = i + 1) begin
            assign level2[i] = level1[2*i] | level1[2*i+1];
        end

        for (i = 0; i < 4; i = i + 1) begin
            assign level3[i] = level2[2*i] | level2[2*i+1];
        end

        for (i = 0; i < 2; i = i + 1) begin
            assign level4[i] = level3[2*i] | level3[2*i+1];
        end
    endgenerate

    assign level5 = level4[0] | level4[1];
    assign zero = ~level5;
endmodule
