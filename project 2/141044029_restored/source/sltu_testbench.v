`define DELAY 20

module sltu_testbench(); 

reg[31:0] rs, rt;
wire[31:0] rd ;

sltu sltu1 (rd, rs, rt);


initial begin
rs = 32'b00000000000000000000000000000000; rt = 32'b11111111111111111111111111111111;  
#`DELAY;
rs = 32'b11111111111111111111111111111111; rt = 32'b00001111100000000000000000000000;  
#`DELAY;
rs = 32'b10000000000001000000000000000011; rt = 32'b00000000000000000000000000001111;  
#`DELAY;

end
 
 
initial
begin
$monitor("time= %2d \n  a = %32b \n  b = %32b \nout = %32b \n\n", $time, rs, rt, rd);
end
 
endmodule
