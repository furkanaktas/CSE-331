module sub(rd, rs, rt );

input signed [31:0] rs,rt;
output signed[31:0] rd;

assign rd = rs - rt;

endmodule 