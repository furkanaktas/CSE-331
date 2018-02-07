`define DELAY 20
module sub_testbench(); 
reg signed[31:0]  rs, rt;
wire signed[31:0] rd;

sub stb ( rd, rs, rt);


initial begin
rs= 32'b00011100011100011100011100011100; rt= 32'b00011100011100011100011100011100;
#`DELAY;

rs= 32'b00000000000000000000000000000001; rt= 32'b10000000000000000000000000000000;
#`DELAY;

end
 
 
initial
begin
$monitor("time = %2d \nrs =%32b\n rt=%32b\n rd=%32b\n\n", $time, rs, rt, rd);
end
 
endmodule