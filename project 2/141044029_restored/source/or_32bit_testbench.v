`define DELAY 20
module or_32bit_testbench(); 

reg[31:0] rs, rt;
wire[31:0] rd ;

or_32bit o32 (rd, rs, rt);


initial begin
rs = 32'b00000000000000000000000000000000; rt = 32'b11111111111111111111111111111111;  
#`DELAY;
rs = 32'b00001111100000000000000000000000; rt = 32'b11111111111111111111111111111111;  
#`DELAY;

end
 
 
initial
begin
$monitor("time = %2d \na =%32b \nb=%32b \nout=%32b \n\n", $time, rs, rt, rd);
end
 
endmodule
