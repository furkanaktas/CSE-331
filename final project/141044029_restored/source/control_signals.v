module control_signals(opcode, regDest, memtoReg, regWr, memRd, memWr, branch, ALUsrc, ALUop);

input [5:0] opcode;

output [4:0] ALUop;
output regDest, memtoReg, regWr, memRd, memWr, branch, ALUsrc;




assign ALUop =  (opcode == 6'b000000) ? ( 5'b00000 ) :  // R type
					 (opcode == 6'b100011) ? ( 5'b00001 ) :  // lw
					 (opcode == 6'b110000) ? ( 5'b00001 ) :  // ll
				    (opcode == 6'b101011) ? ( 5'b00010 ) :  // sw
					 (opcode == 6'b000100) ? ( 5'b00011 ) :  // beq
					 (opcode == 6'b000101) ? ( 5'b00100 ) :  // bne 
					 (opcode == 6'b000010) ? ( 5'b00101 ) :  // j
					 (opcode == 6'b000011) ? ( 5'b00110 ) :  // jal
					 
					 (opcode == 6'b001000) ? ( 5'b00111 ) :  // addi
					 (opcode == 6'b001001) ? ( 5'b01000 ) :  // addiu
					 (opcode == 6'b001010) ? ( 5'b01001 ) :  // slti
					 (opcode == 6'b001011) ? ( 5'b01010 ) :  // sltiu
					 (opcode == 6'b001100) ? ( 5'b01011 ) :  // andi
					 (opcode == 6'b001101) ? ( 5'b01100 ) :  // ori
					
					 
					 (opcode == 6'b100100) ? ( 5'b01101 ) :  // lbu
					 (opcode == 6'b100101) ? ( 5'b01110 ) :  // lhu
					 (opcode == 6'b001111) ? ( 5'b10000 ) :  // lui
					 
					 (opcode == 6'b101000) ? ( 5'b10001 ) :  // sb
					 (opcode == 6'b111000) ? ( 5'b00010 ) :  // sc
					 (opcode == 6'b101001) ? ( 5'b10011 ) :  // sh
					
					
						5'bx ;


assign regDest =  (opcode == 6'b000000) ? ( 1'b1 ) :  // R type      1 rd  yada 0 rt, yazılacak register
						(opcode == 6'b100011) ? ( 1'b0 ) :  // lw
						(opcode == 6'b101011) ? ( 1'bx ) :  // sw
						(opcode == 6'b000100) ? ( 1'bx ) :  // beq
						
						(opcode == 6'b001000) ? ( 1'b0 ) :  // addi
						(opcode == 6'b000101) ? ( 1'bx ) :  // bne
						(opcode == 6'b000010) ? ( 1'b0 ) :  // j
						(opcode == 6'b000011) ? ( 1'bx ) :  // jal
						
						
						(opcode == 6'b001001) ? ( 1'b0 ) :  // addiu
						(opcode == 6'b001010) ? ( 1'b0 ) :  // slti
						(opcode == 6'b001011) ? ( 1'b0 ) :  // sltiu
						(opcode == 6'b001100) ? ( 1'b0 ) :  // andi
						(opcode == 6'b001101) ? ( 1'b0 ) :  // ori
						
						
						 (opcode == 6'b100100) ? ( 1'b0 ) :  // lbu
						 (opcode == 6'b100101) ? ( 1'b0 ) :  // lhu
						 (opcode == 6'b110000) ? ( 1'b0 ) :  // ll
						 (opcode == 6'b001111) ? ( 1'b0 ) :  // lui
						 
						 (opcode == 6'b101000) ? ( 1'bx ) :  // sb
						 (opcode == 6'b111000) ? ( 1'bx ) :  // sc
						 (opcode == 6'b101001) ? ( 1'bx ) :  // sh
						
						1'bx ;

assign ALUsrc =  (opcode == 6'b000000) ? ( 1'b0 ) :  // R type		   1 sign extend yada 0 rt 
					  (opcode == 6'b100011) ? ( 1'b1 ) :  // lw
					  (opcode == 6'b101011) ? ( 1'b1 ) :  // sw
				  	  (opcode == 6'b000100) ? ( 1'b0 ) :  // beq
					  
						(opcode == 6'b001000) ? ( 1'b1 ) :  // addi
						(opcode == 6'b000101) ? ( 1'b0 ) :  // bne
						(opcode == 6'b000010) ? ( 1'b0 ) :  // j
						(opcode == 6'b000011) ? ( 1'b0 ) :  // jal
				
						(opcode == 6'b001001) ? ( 1'b1 ) :  // addiu
						(opcode == 6'b001010) ? ( 1'b1 ) :  // slti
						(opcode == 6'b001011) ? ( 1'b1 ) :  // sltiu
						(opcode == 6'b001100) ? ( 1'b1 ) :  // andi
						(opcode == 6'b001101) ? ( 1'b1 ) :  // ori
				
		
		
						 (opcode == 6'b100100) ? ( 1'b1 ) :  // lbu
						 (opcode == 6'b100101) ? ( 1'b1 ) :  // lhu
						 (opcode == 6'b110000) ? ( 1'b1 ) :  // ll
						 (opcode == 6'b001111) ? ( 1'bx ) :  // lui
						 
						 (opcode == 6'b101000) ? ( 1'b1 ) :  // sb
						 (opcode == 6'b111000) ? ( 1'b1 ) :  // sc
						 (opcode == 6'b101001) ? ( 1'b1 ) :  // sh
						
						
						1'bx ;

	
assign memtoReg =  (opcode == 6'b000000) ? ( 1'b0 ) :  // R type
					    (opcode == 6'b100011) ? ( 1'b1 ) :  // lw
					    (opcode == 6'b101011) ? ( 1'b0 ) :  // sw
				  	    (opcode == 6'b000100) ? ( 1'bx ) :  // beq
					     
						(opcode == 6'b001000) ? ( 1'b0 ) :  // addi
						(opcode == 6'b000101) ? ( 1'bx ) :  // bne
						(opcode == 6'b000010) ? ( 1'b0 ) :  // j
						(opcode == 6'b000011) ? ( 1'b0 ) :  // jal
		
						(opcode == 6'b001001) ? ( 1'b0 ) :  // addiu
						(opcode == 6'b001010) ? ( 1'b0 ) :  // slti
						(opcode == 6'b001011) ? ( 1'b0 ) :  // sltiu
						(opcode == 6'b001100) ? ( 1'b0 ) :  // andi
						(opcode == 6'b001101) ? ( 1'b0 ) :  // ori
		


		
						 (opcode == 6'b100100) ? ( 1'b1 ) :  // lbu
						 (opcode == 6'b100101) ? ( 1'b1 ) :  // lhu
						 (opcode == 6'b110000) ? ( 1'b1 ) :  // ll
						 (opcode == 6'b001111) ? ( 1'b0 ) :  // lui
						 
						 (opcode == 6'b101000) ? ( 1'b0 ) :  // sb
						 (opcode == 6'b111000) ? ( 1'b0 ) :  // sc
						 (opcode == 6'b101001) ? ( 1'b0 ) :  // sh
						
						
						1'b0 ;
					 
					
assign regWr =  (opcode == 6'b000000) ? ( 1'b1 ) :  // R type
				    (opcode == 6'b100011) ? ( 1'b1 ) :  // lw
				    (opcode == 6'b101011) ? ( 1'b0 ) :  // sw
				    (opcode == 6'b000100) ? ( 1'b0 ) :  // beq
				     
						(opcode == 6'b001000) ? ( 1'b1 ) :  // addi
						(opcode == 6'b000101) ? ( 1'b0 ) :  // bne
						(opcode == 6'b000010) ? ( 1'b0 ) :  // j
						(opcode == 6'b000011) ? ( 1'b1 ) :  // jal  R[31] = PC +8
						
						(opcode == 6'b001001) ? ( 1'b1 ) :  // addiu
						(opcode == 6'b001010) ? ( 1'b1 ) :  // slti
						(opcode == 6'b001011) ? ( 1'b1 ) :  // sltiu
						(opcode == 6'b001100) ? ( 1'b1 ) :  // andi
						(opcode == 6'b001101) ? ( 1'b1 ) :  // ori
						
						 
						 
						 (opcode == 6'b100100) ? ( 1'b1 ) :  // lbu
						 (opcode == 6'b100101) ? ( 1'b1 ) :  // lhu
						 (opcode == 6'b110000) ? ( 1'b1 ) :  // ll
						 (opcode == 6'b001111) ? ( 1'b1 ) :  // lui
						 
						 (opcode == 6'b101000) ? ( 1'b0 ) :  // sb
						 (opcode == 6'b111000) ? ( 1'b0 ) :  // sc
						 (opcode == 6'b101001) ? ( 1'b0 ) :  // sh
						
						1'bx ;
		
assign memRd =  (opcode == 6'b000000) ? ( 1'b0 ) :  // R type
					 (opcode == 6'b100011) ? ( 1'b1 ) :  // lw
					 (opcode == 6'b101011) ? ( 1'b0 ) :  // sw
						
						
					 (opcode == 6'b100100) ? ( 1'b1 ) :  // lbu
					 (opcode == 6'b100101) ? ( 1'b1 ) :  // lhu
					 (opcode == 6'b110000) ? ( 1'b1 ) :  // ll
					 (opcode == 6'b001111) ? ( 1'b0 ) :  // lui
					 
					 (opcode == 6'b101000) ? ( 1'b0 ) :  // sb
					 (opcode == 6'b111000) ? ( 1'b0 ) :  // sc
					 (opcode == 6'b101001) ? ( 1'b0 ) :  // sh
						
						1'b0 ;		
					  
					  
assign memWr =  (opcode == 6'b000000) ? ( 1'b0 ) :  // R type
					 (opcode == 6'b100011) ? ( 1'b0 ) :  // lw
					 (opcode == 6'b101011) ? ( 1'b1 ) :  // sw
						
					 (opcode == 6'b100100) ? ( 1'b0 ) :  // lbu
					 (opcode == 6'b100101) ? ( 1'b0 ) :  // lhu
					 (opcode == 6'b110000) ? ( 1'b0 ) :  // ll
					 (opcode == 6'b001111) ? ( 1'b0 ) :  // lui
					 
					 (opcode == 6'b101000) ? ( 1'b1 ) :  // sb
					 (opcode == 6'b111000) ? ( 1'b1 ) :  // sc
					 (opcode == 6'b101001) ? ( 1'b1 ) :  // sh
						
						1'b0 ;


assign branch =  (opcode == 6'b000100) ? ( 1'b1 ) :  // beq
					  (opcode == 6'b000101) ? ( 1'b1 ) :  // bne 
					  
				
						1'b0 ;
					  
					
						
						
						
						
endmodule						