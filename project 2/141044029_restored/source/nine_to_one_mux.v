//https://github.com/uttu357/alu-8bit/blob/master/four_to_one_mux.v
//https://stackoverflow.com/questions/23203576/continuous-assignment-verilog
module nine_to_one_mux(funct, sll_out, srl_out, sra_out, add_out, addu_out, and_out, or_out, sub_out, sltu_out, out);

input [5:0] funct;
input [31:0] sll_out, srl_out, sra_out, add_out, addu_out, and_out, or_out, sub_out, sltu_out;
output reg [31:0] out;

reg [5:0] x; 

always@(*) begin
	x = funct;
	case (x[5:0])
	  6'b000000 : out = sll_out;
	  6'b000010 : out = srl_out;
	  6'b000011 : out = sra_out;
	  6'b100000 : out = add_out;
	  6'b100001 : out = addu_out;
	  6'b100100 : out = and_out;
	  6'b100101 : out = or_out;
	  6'b100010 : out = sub_out;
	  6'b101011 : out = sltu_out;
	  default   : out = 32'b00000000000000000000000000000000;
	endcase
end


endmodule