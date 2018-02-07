module mips_core(clock);
input clock;

wire [31:0] instruction;

wire [31:0] write_data, read_data, read_data_1, read_data_2, ALU_inp2, ALU_result, shifted;
wire  regDest, memtoReg, regWr, memRd, memWr, branch, ALUsrc, zero, branch_ctrl; //control sinyalleri
wire [31:0] write_data2, read_data2, read_data_12, read_data_22;


wire [4:0] write_reg, read_reg_1, read_reg_2, reg_out, ALUop;
wire [5:0] opcode, func;
wire signed [31:0] signExtend, zeroExtend_imm;

wire [4:0] ALU_Control_Sig_out;

assign signExtend = $signed(instruction[15:0]) ;   // sign extend 32 bit
assign zeroExtend_imm = $unsigned(instruction[15:0]) ;  // zero exten 32bit
assign opcode = instruction[31:26];
assign func = instruction[5:0];
assign  write_reg  = instruction[15:11];  //rd
assign  read_reg_2 = instruction[20:16]; //rt
assign  read_reg_1 = instruction[25:21]; //rs

reg[31:0] PC = 32'b0;
wire signal_reg_write; 

reg tempMemRd=1'b0;
reg tempMemWr=1'b0;
reg [5:0]tempOP =5'b00000;

mips_instr_mem instructionmem(instruction, PC);

control_signals ctlSig(opcode, regDest, memtoReg, regWr, memRd, memWr, branch, ALUsrc, ALUop);




assign reg_out =  (ALUop == 5'b00110) ? ( 5'b11111)  :   // for jal  R[31] = ,pc +8(biz +2 yapıcaz)
						(regDest == 1'b1) ? ( write_reg )  :  // R type  rd
					   (regDest == 1'b0) ? ( read_reg_2 ) :  // i type    rt
					    5'bx;
					
mips_registers registers(read_data_1, read_data_2, write_data, read_reg_1, read_reg_2, reg_out, 1'b0, clock); //okuma için


assign ALU_inp2 = (opcode == 6'b001100 || opcode == 6'b001101) ? (zeroExtend_imm) :  // andi yada ori  ise
						(opcode == 6'b001111) ? ({instruction[15:0],16'b0}) :  //lui
						(ALUsrc == 1'b0 ) ? ( read_data_2 ) :  // Rt
						(ALUsrc == 1'b1 ) ? ( signExtend )   : // signExtend
						 32'bx;


ALU_Control_Sig aluCtrlSig(ALUop, func, ALU_Control_Sig_out);
						
ALU alu0(ALU_Control_Sig_out, read_data_1, ALU_inp2, ALU_result, zero );


always @(clock)
begin
tempMemRd = memRd;
tempMemWr = memWr;
tempOP = opcode;  // for sh , sb
//$monitor("ins: %32b, read: %32b , PC:%d",instruction, read_data2, PC);
end



mips_data_mem mem0(read_data, ALU_result, read_data_2, tempMemRd, tempMemWr, tempOP);




assign shifted = (func == 6'b000000) ? ( ALU_inp2 << instruction[10:6]) :  // sll
					  (func == 6'b000010) ? ( ALU_inp2 >> instruction[10:6]) :  // srl	
						32'bx;


wire [31:0] data_mem_result;

assign data_mem_result = (opcode == 6'b100100) ? ( {24'b0,read_data[7:0]} ) :  // lbu
								 (opcode == 6'b100101) ? ( {16'b0,read_data[15:0]} ) :  // lhu
								 (opcode == 6'b100011 || opcode == 6'b110000) ? ( read_data ) :  // lw , ll
								  32'bx;
									
						
						
assign write_data2 = ((func == 6'b000000 || func == 6'b000010) && opcode == 6'b000000 ) ? (shifted) :  //sll srl
						   ( ALUop == 5'b00110 ) ? ( PC + 2 ): 				// jal için R[31] değeri
						   ( memtoReg == 1'b0  ) ? ( ALU_result ) :  		// I, R type
						   ( memtoReg == 1'b1  ) ? ( data_mem_result )  :  // load word, byte vs.
						     32'bx;


wire [31:0] b_or_pc, branch_adress, jump_adress, temp_PC;
wire [27:0] temp_jump;

assign branch_adress = signExtend ;
assign branch_ctrl = branch & zero;

assign b_or_pc =   (branch_ctrl == 1'b1) ? ( branch_adress + 1 ) : 1;						


assign temp_PC = PC+1;	
assign temp_jump = {2'b0,instruction[25:0]};						
assign jump_adress = {temp_PC[31:28], temp_jump	};

wire [31:0] add_part;	// PC + add_part , PC ye  ne ekleneceğidir, jumpsa ona göre işlem branch'se ona göre hiçbiri değilse 1  vs.

assign add_part =   (func == 6'b001000 & opcode == 6'b000000) ? (read_data_1 - PC) : // jr
						  (ALUop == 5'b00101 || ALUop == 5'b00110) ? ( jump_adress - PC )   : // j or jal
						   b_or_pc;	
							


							
assign signal_reg_write = (func == 6'b001000 && opcode == 6'b000000) ? ( 1'b0 ):  // jr ise register a yazmamak için sinyal değişti
									regWr;  

					 
mips_registers registers2(read_data_12, read_data_22, write_data2, read_reg_1, read_reg_2, reg_out, signal_reg_write, clock); // yazma için

/*
always @ signal_reg_write  // PC ekrana yazdırmak için
begin
$monitor("pc : %d",PC);
end
*/				 
always @(posedge clock && add_part)
begin 
//$monitor("ins: %32b, write_data: %32b, reg:%5b,  sig:%1b, memrd:%1b, memwr:%1b, PC:%d",instruction, write_data2, reg_out, signal_reg_write, memRd, memWr, PC);
PC = PC + add_part;
end 




endmodule