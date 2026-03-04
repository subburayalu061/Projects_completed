module ALU_Decoder(
    input  [1:0] ALUOp,
    input  [2:0] funct3,
    input  [6:0] funct7,
    output reg [3:0] cntl
);

always @(*) begin

    case(ALUOp)

        2'b00: cntl = 4'b0011;

        2'b01: cntl = 4'b0100; 

        2'b10: begin
            case(funct3)

                3'b000: begin
                    if (funct7[5])
                        cntl = 4'b0100;
                    else
                        cntl = 4'b0011;
                end

                3'b111: cntl = 4'b0000; 
                3'b110: cntl = 4'b0001;
                3'b100: cntl = 4'b0010;
                3'b010: cntl = 4'b0101;
                3'b011: cntl = 4'b0110;
                3'b001: cntl = 4'b0111;

                3'b101: begin
                    if (funct7[5])
                        cntl = 4'b1000;
                    else
                        cntl = 4'b1001;
                end

                default: cntl = 4'b0011;
            endcase
        end

        2'b11: cntl = 4'b1010;

        default: cntl = 4'b0011;

    endcase

end

endmodule
