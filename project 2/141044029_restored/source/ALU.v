//https://github.com/uttu357/alu-8bit/blob/master/alu.v
module ALU(opcode, inp1, inp2, out, shamt,  funct);

input [5:0] opcode, funct;
input [31:0] inp1, inp2;
input [4:0] shamt;

output  [31:0] out;
wire [31:0] sll_out, srl_out, sra_out, add_out, addu_out, and_out, or_out, sub_out, sltu_out;

sll 		sll1(.rd(sll_out), .rt(inp2), .shamt(shamt));
srl 		srl1(.rd(srl_out), .rt(inp2), .shamt(shamt));
sra 		sra1(.rd(sra_out), .rt(inp2), .shamt(shamt));
add 		add1(.rd(add_out), .rs(inp1), .rt(inp2));
addu 		addu1(.rd(addu_out), .rs(inp1), .rt(inp2));
and_32bit and1(.rd(and_out), .rs(inp1), .rt(inp2));
or_32bit  or1(.rd(or_out), .rs(inp1), .rt(inp2));
sub 		sub1(.rd(sub_out), .rs(inp1), .rt(inp2));
sltu sltu1(.rd(sltu_out), .rs(inp1), .rt(inp2));


nine_to_one_mux mux1(.funct(funct), .sll_out(sll_out), .srl_out(srl_out), .sra_out(sra_out), .add_out(add_out), .addu_out(addu_out), .and_out(and_out), .or_out(or_out), .sub_out(sub_out), .sltu_out(sltu_out), .out(out));


endmodule
