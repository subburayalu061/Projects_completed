`timescale 1ns / 1ps

module ALU(
input wire [3:0] cntl,
input wire [31:0] a,
input wire [31:0] b,
output reg neg,
output reg zero,
output reg [31:0] x
 );
    always@(*) begin
    case(cntl)
    4'b0000:x = a & b;
    4'b0001:x = a | b;
    4'b0010:x = a ^ b;
    4'b0011:x = a + b;
    4'b0100:x = a + (~b + 1);
    4'b0101:x = ($signed(a) < $signed(b)) ? 1:0;
    4'b0110:x =(a < b) ? 1:0;
    4'b0111:x = a << b[4:0];
    4'b1000:x = $signed(a) >>> b;
    4'b1001:x = a >> b[4:0];
    4'b1010:x = b;
    default:x = 0;
    endcase
    zero <= ( x == 0 );
    end
endmodule