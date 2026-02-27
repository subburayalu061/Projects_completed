module RISC_V(
    input  wire clk,
    input  wire reset
);
    
wire regwrite,memwrite,memread,ALUSrc,zero,branch,jal,jalr,PCSrc; 
wire [1:0] ResultSrc,ALUop;
wire [3:0] cntl; 
wire [31:0] a,b,rd1,rd2,x,pc,next_pc,instr,reg_data,mem_out,Immb,ImmPC;

assign PCSrc = zero & branch;
assign a = rd1;
assign b = (ALUSrc) ? Immb : rd2;
assign reg_data = (ResultSrc == 2'b01) ? mem_out : x;



PC_Adder PC_Adder(
    .pc(pc),
    .imm(Immb),
    .rs1_data(rd1),
    .branch_taken(PCSrc),
    .jal(jal),
    .jalr(jalr),
    .reset(reset),
    .next_pc(next_pc)
);

Program_Counter Program_Counter(
    .clk(clk),
    .reset(reset),
    .next_pc(next_pc),
    .pc(pc)
);

Instruction_Mem Instruction_Mem(
.clk(clk),
.reset(reset),
.pointer(pc),
.inst(instr)
);

Register Register(
    .clk(clk),
    .reset(reset),
    .regwrite(regwrite),
    .ad1(instr[19:15]),
    .ad2(instr[24:20]),
    .wri_add(instr[11:7]),
    .write(reg_data),
    .rd1(rd1),
    .rd2(rd2)
);

Imm_Ext Imm_Ext(
    .instr(instr),
    .imm(Immb)
);

Control_Unit Control_Unit(
    .opcode(instr[6:0]),
    .RegWrite(regwrite),
    .MemRead(memread),
    .MemWrite(memwrite),
    .Branch(branch),
    .Jump(jal),
    .ALUSrc(ALUSrc),
    .ALUOp(ALUop),
    .ResultSrc(ResultSrc),
    .Jalr(jalr)
);

ALU_Decoder ALU_Decoder(
    .ALUOp(ALUop),
    .funct3(instr[14:12]),
    .funct7(instr[31:25]),
    .cntl(cntl)
);

ALU ALU(
.cntl(cntl),
.a(a),
.b(b),
.neg(),
.zero(zero),
.x(x)
 );

Data_Mem Data_Mem(
    .clk(clk),
    .reset(reset),
    .MemWrite(memwrite),
    .MemRead(memread),
    .addr(x),
    .write_data(rd2),
    .read_data(mem_out)
);


endmodule