`define DELAY 20
module mips_core_testbench ();

reg [31:0] instruction_set;
wire [31:0] result;

mips_core mctb(instruction_set, result);

initial begin

instruction_set = 32'b00000000000000010001000001000000; //#10; sll  2  1 << (1 bit)
#`DELAY;
instruction_set = 32'b00000000011001000010100001000010; //#10; srl  5  4 >> (1 bit)
#`DELAY;
instruction_set = 32'b00000000110001110100000011000011; //#10; sra  8  7 >>> (3 bit)
#`DELAY;
instruction_set = 32'b00000001001010100101101000100000; //#10; add  11 9 10
#`DELAY;
instruction_set = 32'b00000001100011010111001000100001; //#10; addu 14 12 13
#`DELAY;
instruction_set = 32'b00000001111100001000101000100100; //#10; and  17 15 16
#`DELAY;
instruction_set = 32'b00000010010100111010001000100101; //#10; or   20 18 19
#`DELAY;
instruction_set = 32'b00000010101101101011101000100010; //#10; sub  23 21 22
#`DELAY;
instruction_set = 32'b00000011000110011101001000101011; //#10; sltu 26 24 25
#`DELAY;

end


initial
begin
$monitor("instruction: %32b, result: %32b", instruction_set, result);
end
 
endmodule
