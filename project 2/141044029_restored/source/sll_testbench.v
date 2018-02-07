`define DELAY 20
module sll_testbench(); 

reg [31:0] rt;
reg [4:0] shamt;
wire [31:0] rd;


sll sll0 (rd, rt, shamt);


initial begin
rt = 32'b11111111111111111111111111111111;  shamt = 5'b00001 ;
#`DELAY;
rt = 32'b11111111111111111111111111111111;  shamt = 5'b00011 ;
#`DELAY;
rt = 32'b11111111111111111111111111111111;  shamt = 5'b11111 ;
#`DELAY;

end
 
 
initial
begin
$monitor("time = %2d \n   a = %32b \n   b = %5b \n out = %32b \n\n", $time, rt, shamt, rd);
end
 
endmodule
