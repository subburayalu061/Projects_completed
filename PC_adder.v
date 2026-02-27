module PC_Adder (
    input  wire [31:0] pc,
    input  wire [31:0] imm,
    input  wire [31:0] rs1_data,
    input  wire branch_taken,
    input  wire jal,
    input  wire jalr,
    input wire reset,
    output reg [31:0] next_pc
);

    wire [31:0] pc_plus4;
    wire [31:0] pc_plus_imm;
    wire [31:0] jalr_target;

    assign pc_plus4     = pc + 32'd4;
    assign pc_plus_imm  = pc + imm;
    assign jalr_target  = (rs1_data + imm) & 32'hFFFFFFFE;

    always @(*) begin
    if(reset)
    next_pc <= 32'b0;
    else if (jalr)
    next_pc = jalr_target;
    else if (jal || branch_taken)
    next_pc = pc_plus_imm;
    else
    next_pc = pc_plus4;
    end
    endmodule