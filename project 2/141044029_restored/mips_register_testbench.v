`define DELAY 20

module mips_registers_testbench(); 

	wire [31:0] read_data_1, read_data_2;
	reg[31:0] write_data;
	reg [4:0] read_reg_1, read_reg_2, write_reg;
	reg signal_reg_write, clk;

	mips_registers reg0 ( read_data_1, read_data_2, write_data, read_reg_1, read_reg_2, write_reg, signal_reg_write, clk );


	initial begin
		write_data = 32'b00001111100000000000000000000000; read_reg_1 = 00000; read_reg_2 = 00001; write_reg=00011; signal_reg_write=0; clk=0; 
		#`DELAY;
		write_data = 32'b00001111100000000000000000000000; read_reg_1 = 00000; read_reg_2 = 00001; write_reg=00011; signal_reg_write=1; clk=1; 
		#`DELAY;

	end
	 
	 
	initial
	begin
		$monitor("data1 = %32b \ndata2 = %32b \n\n", read_data_1, read_data_2);
	end
 
endmodule
