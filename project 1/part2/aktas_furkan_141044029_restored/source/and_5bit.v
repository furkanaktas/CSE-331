module and_5bit (out, a, b);
input [4:0] a, b;
output [4:0] out;

assign out[0] = a[0] & b[0];
assign out[1] = a[1] & b[1];
assign out[2] = a[2] & b[2];		// inputların her biti and lendi
assign out[3] = a[3] & b[3];
assign out[4] = a[4] & b[4];

endmodule