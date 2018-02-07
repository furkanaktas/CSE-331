module sra(rd, rt, shamt );

input signed [31:0] rt;
input [4:0] shamt;
output signed[31:0] rd;

assign rd = rt >>> shamt;

endmodule 