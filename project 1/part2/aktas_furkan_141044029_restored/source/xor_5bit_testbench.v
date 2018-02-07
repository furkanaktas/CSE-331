`define DELAY 20

module xor_5bit_testbench(); 

reg[4:0] a, b;
wire[4:0] out ;

xor_5bit fatp (out, a, b);


initial begin
a = 5'b00000; b = 5'b11111;  
#`DELAY;

a = 5'b10101; b = 5'b01010;  
#`DELAY;

a = 5'b10101; b = 5'b10101;  
#`DELAY;

end
 
 
initial
begin
$monitor("time = %5d, a =%5b, b=%5b, out=%5b", $time, a, b, out);
end
 
endmodule