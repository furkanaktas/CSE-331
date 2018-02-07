`define DELAY 20
module sra_testbench(); 

reg [31:0] rt;
reg unsigned[4:0] shamt;
wire [31:0] rd;


sra sra0 (rd, rt, shamt);


initial begin
rt = 32'b10000000000000001111111111111111;  shamt = 5'b00001 ;
#`DELAY;
rt = 32'b10000111111111111111111111100000;  shamt = 5'b00011 ;
#`DELAY;
rt = 32'b00000111110000011111111111100000;  shamt = 5'b11111 ;
#`DELAY;

end
 
 
initial
begin
$monitor("time= %2d \n   a = %32b \n   b = %5b \n out = %32b \n\n", $time, rt, shamt, rd);
end
 
endmodule
