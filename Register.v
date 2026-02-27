`timescale 1ns / 1ps

module Register(
    input  wire        clk,
    input  wire        reset,
    input  wire        regwrite,
    input  wire [4:0]  ad1,
    input  wire [4:0]  ad2,
    input  wire [4:0]  wri_add,
    input  wire [31:0] write,
    output wire [31:0] rd1,
    output wire [31:0] rd2
);

    reg [31:0] regs [31:0];
    integer i;


    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1)
                regs[i] <= 32'b0;
        end
        else if (regwrite && (wri_add != 5'd0)) begin
            regs[wri_add] <= write;
        end
    end

    assign rd1 = (ad1 == 5'd0) ? 32'b0 : regs[ad1];
    assign rd2 = (ad2 == 5'd0) ? 32'b0 : regs[ad2];

endmodule