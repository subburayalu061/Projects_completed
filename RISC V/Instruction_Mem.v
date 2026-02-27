module Instruction_Mem(
input wire clk,
input wire reset,
input wire [31:0] pointer,
output reg [31:0] inst
);

reg [31:0] mem [0:255]; 

always@(posedge clk or posedge reset)begin
if (reset)
inst <= 32'b0;
else
inst <= mem [pointer[31:2]];
end
endmodule
