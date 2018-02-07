module likeALU( out, inp_A, inp_B, select );

input  [4:0] inp_A, inp_B;
input [1:0] select;
output  [4:0] out;
wire C;

wire [4:0] and_result, add_result, or_result, xor_result;

and_5bit an5( .out(and_result), .a(inp_A), .b(inp_B) );			// inp_A ve inp_B  and lendi

adder_5bit ad5( .S(add_result), .C(C)  , .A(inp_A), .B(inp_B), .C0(1'b0) );		// inp_A ve inp_B  toplandı

or_5bit or5( .out(or_result), .a(inp_A), .b(inp_B) ); 		// inp_A ve inp_B  or landı

xor_5bit xo5( .out(xor_result) , .a(inp_A), .b(inp_B) ); 	// inp_A ve inp_B  xor landı


mux_5bit mu5(  .out(out), .a(and_result), .b(add_result), .c(or_result), .d(xor_result), .select(select) ); // and add or xor, mux'a yollandı


endmodule