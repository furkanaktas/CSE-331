module addu(rd, rs, rt );

input unsigned [31:0] rs,rt;
output unsigned [31:0] rd;

assign rd = rs + rt;

endmodule 