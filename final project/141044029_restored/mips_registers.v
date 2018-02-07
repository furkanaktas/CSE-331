module mips_registers
(
	output reg [31:0] read_data_1, read_data_2,
	input [31:0] write_data,
	input [4:0] read_reg_1, read_reg_2, write_reg,
	input signal_reg_write, clk
);
	reg [31:0] registers [31:0];
	
	//1 kere okunuyor. 
	//diğer işlemler register file üstünde yapılıyor.
	initial begin
		$readmemb("registers.mem", registers);
		
	end

	//combinational block use always @*, assign, = 
	//sequential blocks use always@(posedge clk), <=
	// <= nonblocking, = blocking
	always @(clk) //for combinational 
	//	or always @ (posedge clk) //for sequential
	begin
		if (signal_reg_write) begin
			//$monitor("reg : %5b", write_reg);
			registers[write_reg] = write_data;
			//$monitor("wrt: %32b,  reg: %32b, %5b ",write_data,registers[write_reg], write_reg);
			$writememb("res_registers.mem", registers);
			
		end
		else begin
			read_data_1 = registers[read_reg_1];
			read_data_2 = registers[read_reg_2];
			
		end
	end
endmodule