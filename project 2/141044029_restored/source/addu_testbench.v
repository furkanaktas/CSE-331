`define DELAY 20
module addu_testbench(); 
reg unsigned[31:0]  rs, rt;
wire unsigned[31:0] rd;

addu autb ( rd, rs, rt);


initial begin
rs= 32'b00011100011100011100011100011100; rt= 32'b00011100011100011100011100011100;
#`DELAY;

rs= 32'b00000000000000000000000000000001; rt= 32'b10000000000000000000000000000000;
#`DELAY;


rs= 32'b11111111111111111111111111111111; rt= 32'b00000000000000000000000000000001;
#`DELAY;
end
 
 
initial
begin
$monitor("time = %2d \nrs = %32b   \nrt = %32b  \nrd = %d\n\n", $time, rs, rt, rd);
end
 
endmodule