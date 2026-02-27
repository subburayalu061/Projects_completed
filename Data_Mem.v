module Data_Mem (
    input  wire        clk,
    input  wire        reset,
    input  wire        MemWrite,
    input  wire        MemRead,
    input  wire [31:0] addr,
    input  wire [31:0] write_data,
    output reg  [31:0] read_data
);

    reg [31:0] mem [0:255];
    integer i;

    wire [7:0] word_addr;
    assign word_addr = addr[31:2];  // word-aligned

    // Write + Reset logic
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 256; i = i + 1)
                mem[i] <= 32'b0;
        end
        else if (MemWrite) begin
            mem[word_addr] <= write_data;
        end
    end

    // Read logic (combinational)
    always @(*) begin
        if (MemRead)
            read_data = mem[word_addr];
        else
            read_data = 32'b0;
    end

endmodule