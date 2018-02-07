`define DELAY 20

module adder_5bit_testbench(); 

reg[4:0] A, B;
reg C0;
wire[4:0] S ;
wire C;

adder_5bit fatp (S,C,A,B,C0);


initial begin
A = 5'b10000; B = 5'b00010; C0 = 1'b0; 
#`DELAY;
A = 5'b11111; B = 5'b11111; C0 = 1'b0; 
#`DELAY;
A = 5'b10010; B = 5'b00010; C0 = 1'b0; 
#`DELAY;

end
 
 
initial
begin
$monitor("time = %5d, A=%5b, B=%5b, C=%1b, toplam=%5b", $time, A, B, C, S);
end
 
endmodule