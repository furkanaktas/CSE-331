`define DELAY 20

module likeALU_testbench(); 

reg[4:0] inp_A, inp_B;
reg[1:0] select;
wire[4:0] out ;

likeALU lA (out, inp_A, inp_B, select);


initial begin
inp_A = 5'b11111; inp_B = 5'b00000;  select = 2'b00 ; 
#`DELAY;

inp_A = 5'b10011; inp_B = 5'b00001;  select = 2'b01 ; 
#`DELAY;

inp_A = 5'b11111; inp_B = 5'b00000;  select = 2'b10 ; 
#`DELAY;

inp_A = 5'b11111; inp_B = 5'b00011;  select = 2'b11 ;

end
 
 
initial
begin
$monitor("time = %5d, select=%2b, a=%5b, b=%5b, out=%5b", $time, select, inp_A, inp_B, out);
end
 
endmodule