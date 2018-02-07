module mips_data_mem (read_data, mem_address, write_data, sig_mem_read, sig_mem_write, opcode);
output [31:0] read_data;
input [31:0] mem_address;
input [31:0] write_data;
input sig_mem_read;
input sig_mem_write;
input [5:0] opcode;

reg [31:0] data_mem  [255:0];
reg [31:0] read_data;

initial begin
	$readmemb("data.mem", data_mem);
end

always @( (sig_mem_write && opcode) or sig_mem_read && opcode ) begin
	if (sig_mem_read) begin
		read_data = data_mem[mem_address];
		//$monitor("data: %32b",read_data);
	end
	
	if (sig_mem_write) begin
		
		//$monitor("data_mem: %32b   , data: %32b",data_mem[mem_address], write_data);
		if (opcode == 6'b101000) //sb
			data_mem[mem_address] = { data_mem[mem_address][31:8], write_data[7:0]};
		
		else if (opcode == 6'b101001) // sh
			data_mem[mem_address] = { data_mem[mem_address][31:16], write_data[15:0]};
		else
			data_mem[mem_address] = write_data;
			
		
		$writememb("res_data.mem", data_mem);
	end
end

endmodule