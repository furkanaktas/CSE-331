module mux_5bit( out, a, b, c, d, select );

input [4:0] a,b,c,d;
input [1:0] select;
output [4:0] out;

reg [4:0] out;

always @( select or a or b or c or d)
begin
    out[0] =       ( ~select[0] & ~select[1] & a[0] )
            | (  select[0] & ~select[1] & b[0] )
            | ( ~select[0] &  select[1] & c[0] )
            | (  select[0] &  select[1] & d[0] );
	
	out[1] =       ( ~select[0] & ~select[1] & a[1] )
            | (  select[0] & ~select[1] & b[1] )
            | ( ~select[0] &  select[1] & c[1] )
            | (  select[0] &  select[1] & d[1] );				// select'in ne olduguna göre q belirlendi
				
	out[2] =       ( ~select[0] & ~select[1] & a[2] )
            | (  select[0] & ~select[1] & b[2] )
            | ( ~select[0] &  select[1] & c[2] )
            | (  select[0] &  select[1] & d[2] );
				
	out[3] =       ( ~select[0] & ~select[1] & a[3] )
            | (  select[0] & ~select[1] & b[3] )
            | ( ~select[0] &  select[1] & c[3] )
            | (  select[0] &  select[1] & d[3] );
	
	out[4] =       ( ~select[0] & ~select[1] & a[4] )
            | (  select[0] & ~select[1] & b[4] )
            | ( ~select[0] &  select[1] & c[4] )
            | (  select[0] &  select[1] & d[4] );
end

endmodule