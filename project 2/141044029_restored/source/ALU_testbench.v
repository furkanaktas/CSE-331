`define DELAY 20
module ALU_testbench();

reg [31:0] inp1,inp2;
reg [4:0] shamt;
reg [5:0] opcode,funct;
wire [31:0] out;


ALU alu1 (opcode, inp1, inp2, out, shamt,  funct);


initial begin
opcode = 6'b000000; inp1 = 32'b11111111111111111111111111111111;  inp2 = 32'b00000000000000000000000000000001 ; shamt = 5'b00011 ; funct = 6'b000000;
#`DELAY;
opcode = 6'b000000; inp1 = 32'b11111111111111111111111111111111;  inp2 = 32'b00000000000000000000000000000011 ; shamt = 5'b00011 ; funct = 6'b100000;
#`DELAY;
opcode = 6'b000000; inp1 = 32'b11111111111111111111111111111111;  inp2 = 32'b00000000000000000000000000011111 ; shamt = 5'b00011 ; funct = 6'b100100;
#`DELAY;

end
 
 
initial
begin
$monitor(" time = %2d \nfunct = %6b \n    a = %32b \n    b = %32b \nshamt = %5b\n  out = %32b \n\n", $time, funct, inp1, inp2, shamt, out);
end
 
endmodule
