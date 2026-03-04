module Control_Unit(
    input  [6:0] opcode,
    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg Branch,
    output reg Jump,
    output reg ALUSrc,
    output reg Immb,
    output reg Jalr,
    output reg [1:0] ALUOp,
    output reg [1:0] ResultSrc
);

always @(*) begin
    case(opcode)

        7'b0110011: begin 
            RegWrite=1; MemRead=0; MemWrite=0;
            Branch=0; Jump=0;
            ALUSrc=0; ALUOp=2'b10;
            ResultSrc=2'b00;Immb=0;
        end

        7'b0010011: begin 
            RegWrite=1; MemRead=0; MemWrite=0;
            Branch=0; Jump=0;
            ALUSrc=1; ALUOp=2'b10;
            ResultSrc=2'b00;Immb=1;
        end

        7'b0000011: begin
            RegWrite=1; MemRead=1; MemWrite=0;
            Branch=0; Jump=0;
            ALUSrc=1; ALUOp=2'b00;
            ResultSrc=2'b01;Immb=0;
        end

        7'b0100011: begin
            RegWrite=0; MemRead=0; MemWrite=1;
            Branch=0; Jump=0;
            ALUSrc=1; ALUOp=2'b00;
            ResultSrc=2'b00;Immb=0;
        end

        7'b1100011: begin
            RegWrite=0; MemRead=0; MemWrite=0;
            Branch=1; Jump=0;
            ALUSrc=0; ALUOp=2'b01;
            ResultSrc=2'b00;Immb=0;
        end

        7'b0110111: begin 
            RegWrite=1; MemRead=0; MemWrite=0;
            Branch=0; Jump=0;
            ALUSrc=1; ALUOp=2'b11;
            ResultSrc=2'b10;Immb=0;
        end

        7'b0010111: begin
            RegWrite=1; MemRead=0; MemWrite=0;
            Branch=0; Jump=0;
            ALUSrc=1; ALUOp=2'b00;
            ResultSrc=2'b00;Immb=0;
        end

7'b1101111: begin 
    RegWrite = 1;
    MemRead  = 0;
    MemWrite = 0;
    Branch   = 0;
    Jump     = 1;
    ALUSrc   = 0;   // don't care actually
    ALUOp    = 2'b00; // don't care
    ResultSrc = 2'b11; // select PC+4
    Jalr = 0;
end

7'b1100111: begin
    RegWrite = 1;
    MemRead  = 0;
    MemWrite = 0;
    Branch   = 0;
    Jump     = 0;
    ALUSrc   = 1;  
    ALUOp    = 2'b00; 
    ResultSrc = 2'b11; 
    Jalr = 1;    
end

        default: begin
            RegWrite=0; MemRead=0; MemWrite=0;
            Branch=0; Jump=0;
            ALUSrc=0; ALUOp=2'b00;
            ResultSrc=2'b00;Immb=0;
        end
    endcase
end

endmodule
