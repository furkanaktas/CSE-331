module ALU_Control_Sig(ALUop, func, ALU_Control_Sig_out);

input [4:0] ALUop;
input [5:0] func;
output [4:0] ALU_Control_Sig_out;

wire [4:0]  Rtype_sig;




assign Rtype_sig =  (func == 6'b100000) ? ( 5'b00000 ) :  // add
					     (func == 6'b100001) ? ( 5'b00001 ) :  // addu
					     (func == 6'b100010) ? ( 5'b00010 ) :  // sub
						  (func == 6'b100011) ? ( 5'b00011 ) :  // subu
						  (func == 6'b100100) ? ( 5'b00100 ) :  // and
						  (func == 6'b100101) ? ( 5'b00101 ) :  // or
						  (func == 6'b100111) ? ( 5'b00110 ) :  // nor
						  (func == 6'b101010) ? ( 5'b00111 ) :  // slt
						  (func == 6'b101011) ? ( 5'b01000 ) :  // sltu
						  
						 
						   5'bx ;

						

assign ALU_Control_Sig_out = (ALUop == 5'b00000) ? ( Rtype_sig ) :  // R type
									  (ALUop == 5'b00001) ? ( 5'b00000 ) :  // lw
									  (ALUop == 5'b00010) ? ( 5'b00000 ) :  // sw
									  (ALUop == 5'b00011) ? ( 5'b01101 ) :  // beq
									  (ALUop == 5'b00100) ? ( 5'b01110 ) :  // bne 
									 
									  (ALUop == 5'b00111) ? ( 5'b00000 ) :  // addi
									  (ALUop == 5'b01000) ? ( 5'b01001 ) :  // addiu
									  (ALUop == 5'b01001) ? ( 5'b00111 ) :  // slti
									  (ALUop == 5'b01010) ? ( 5'b01010 ) :  // sltiu
									  (ALUop == 5'b01011) ? ( 5'b00100 ) :  // andi
									  (ALUop == 5'b01100) ? ( 5'b00101 ) :  // ori
										
									 (ALUop == 5'b01101) ? ( 5'b01001 ) :  // lbu
									 (ALUop == 5'b01110) ? ( 5'b01001 ) :  // lhu
									 (ALUop == 5'b01111) ? ( 5'b00000 ) :  // ll
									 (ALUop == 5'b10000) ? ( 5'b11111 ) :  // lui
									 
									 (ALUop == 5'b10001) ? ( 5'b00000 ) :  // sb
									 (ALUop == 5'b10010) ? ( 5'b00000 ) :  // sc
									 (ALUop == 5'b10011) ? ( 5'b00000 ) :  // sh									  
									  5'bx ;

										
					

endmodule