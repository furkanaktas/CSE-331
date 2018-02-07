`define DELAY 20
module mux_5bit_testbench(); 
reg[4:0] a, b, c ,d;
reg[1:0] select;
wire[4:0] out ;

mux_5bit fatb ( out, a, b, c, d, select );


initial begin
select = 2'b00 ; a = 5'b10000; b = 5'b00010; c = 5'b00000; d = 5'b01101; 
#`DELAY;
select = 2'b01 ; a = 5'b10000; b = 5'b00010; c = 5'b00000; d = 5'b01101; 
#`DELAY;
select = 2'b10 ; a = 5'b10000; b = 5'b00010; c = 5'b00000; d = 5'b01101; 
#`DELAY;
select = 2'b11 ; a = 5'b10000; b = 5'b00010; c = 5'b00000; d = 5'b01101; 
#`DELAY;

end
 
 
initial
begin
$monitor("time = %2d, select=%2b, a =%5b, b=%5b, c=%5b, d=%5b, out=%5b", $time, select, a, b, c, d, out);
end
 
endmodule