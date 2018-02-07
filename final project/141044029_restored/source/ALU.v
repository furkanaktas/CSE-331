module ALU(control, inp1, inp2, out, zero);

input [31:0] inp1, inp2;
input [4:0] control;
output [31:0] out;
output zero;

assign out = (control == 5'b00000) ? ( $signed(inp1) + $signed(inp2) )   :    // add
				 (control == 5'b00001) ? ( $unsigned(inp1) + $unsigned(inp2) ) :  // addu	
				 (control == 5'b00010) ? ( $signed(inp1) - $signed(inp2) )   :    // sub
				 (control == 5'b00011) ? ( $unsigned(inp1) - $unsigned(inp2) ) :  // subu
				 (control == 5'b00100) ? ( inp1 & inp2 )   :  // and
				 (control == 5'b00101) ? ( inp1 | inp2  )  :  // or
				 (control == 5'b00110) ? ( ~(inp1 | inp2)) :  // nor
				 (control == 5'b00111) ? ( $signed(inp1) < $signed(inp2)  )  :     // slt
				 (control == 5'b01000) ? ( $unsigned(inp1) < $unsigned(inp2)  ) :  // sltu
				 
				 (control == 5'b01001) ? ( $unsigned(inp1) + $signed(inp2) ) :  // addiu lbu lhu 
				 (control == 5'b01010) ? ( $unsigned(inp1) < $signed(inp2) ) :  // sltiu
				 
				 (control == 5'b11111) ? ( inp2 ) :  // lui
				 
				  32'bx;
		
assign zero = (control == 5'b01101) ? ( inp1 == inp2  ) :  // beq		
				  (control == 5'b01110) ? ( inp1 != inp2  ) :  // bne		
					1'b0;
						  
						 
endmodule
