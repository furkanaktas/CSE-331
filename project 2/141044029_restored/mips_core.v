module mips_core(instruction, result);

input [31:0] instruction;
output [31:0] result;

wire [4:0] rs,rt,rd,shamt;
wire [5:0] opcode,funct;
wire [31:0] read_data_1, read_data_2, write_data,a;

assign funct = instruction[5:0];
assign shamt = instruction[10:6];
assign rd = instruction[15:11];
assign rt = instruction[20:16];
assign rs = instruction[25:21];
assign opcode = instruction[31:26];

reg clk = 1'b0, writeSignal = 1'b0;

mips_registers reg1(.read_data_1(read_data_1), .read_data_2(read_data_2), .write_data(write_data), .read_reg_1(rs), .read_reg_2(rt), .write_reg(rd), .signal_reg_write(writeSignal), .clk(clk) );
ALU alu0 (.opcode(opcode), .inp1(read_data_1), .inp2(read_data_2), .out(write_data), .shamt(shamt), .funct(funct));

/*
always @* begin
		$display("R1: %b  \nR2: %b   \nW1: %b",read_data_1, read_data_2, write_data);
end
*/

assign result = write_data;

always @(writeSignal) 
begin
	writeSignal = 1'b1;
	clk = 1'b1;
end

endmodule