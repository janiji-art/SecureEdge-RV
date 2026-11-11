
module alu (
    input  wire [31:0] a,
    input  wire [31:0] b,
    input  wire [3:0]  alu_control,
    output reg  [31:0] result,
    output wire        zero
);

    // ALU operation codes
    localparam ADD  = 4'b0000;
    localparam SUB  = 4'b0001;
    localparam AND  = 4'b0010;
    localparam OR   = 4'b0011;
    localparam XOR  = 4'b0100;
    localparam SLL  = 4'b0101;
    localparam SRL  = 4'b0110;
    localparam SRA  = 4'b0111;
    localparam SLT  = 4'b1000;
    localparam SLTU = 4'b1001;

    always @(*) begin
        result = 32'b0;

        case (alu_control)

            ADD:  result = a + b;
            SUB:  result = a - b;
            AND:  result = a & b;
            OR:   result = a | b;
            XOR:  result = a ^ b;
            SLL:  result = a << b[4:0];
            SRL:  result = a >> b[4:0];
            SRA:  result = $signed(a) >>> b[4:0];
            SLT:  result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            SLTU: result = (a < b) ? 32'd1 : 32'd0;

            default: result = 32'b0;

        endcase
    end

    assign zero = ~(
        (
            ((result[0]  | result[1])  | (result[2]  | result[3]))  |
            ((result[4]  | result[5])  | (result[6]  | result[7]))
        ) |
        (
            ((result[8]  | result[9])  | (result[10] | result[11])) |
            ((result[12] | result[13]) | (result[14] | result[15]))
        ) |
        (
            ((result[16] | result[17]) | (result[18] | result[19])) |
            ((result[20] | result[21]) | (result[22] | result[23]))
        ) |
        (
            ((result[24] | result[25]) | (result[26] | result[27])) |
            ((result[28] | result[29]) | (result[30] | result[31]))
        )
    );

endmodule

