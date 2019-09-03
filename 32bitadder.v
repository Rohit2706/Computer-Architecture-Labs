module DECODER(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
	input x,y,z;
	output d0,d1,d2,d3,d4,d5,d6,d7;
	wire x0,y0,z0;
	not n1(x0,x);
	not n2(y0,y);
	not n3(z0,z);
	and a0(d0,x0,y0,z0);
	and a1(d1,x0,y0,z);
	and a2(d2,x0,y,z0);
	and a3(d3,x0,y,z);
	and a4(d4,x,y0,z0);
	and a5(d5,x,y0,z);
	and a6(d6,x,y,z0);
	and a7(d7,x,y,z);
endmodule

module FADDER(s,c,x,y,z);
	input x,y,z;
	wire d0,d1,d2,d3,d4,d5,d6,d7;
	output s,c;
	DECODER dec(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
	assign s = d1 | d2 | d4 | d7,
	c = d3 | d5 | d6 | d7;
endmodule

module 8BITADDER(s,c,x,y,z);
	input [7:0] a,b;
	input z;
	wire f7,f6,f5,f4,f3,f2,f1;
	output c;
	output [7:0] s;
	
	FADDER fadd0(s[0],f1,a[0],b[0],z);
	FADDER fadd1(s[1],f2,a[1],b[1],f1);
	FADDER fadd2(s[2],f3,a[2],b[2],f2);
	FADDER fadd3(s[3],f4,a[3],b[3],f3);
	FADDER fadd4(s[4],f5,a[4],b[4],f4);
	FADDER fadd5(s[5],f6,a[5],b[5],f5);
	FADDER fadd6(s[6],f7,a[6],b[6],f6);
	FADDER fadd7(s[7],c,a[7],b[7],f7);
endmodule

module 32BITADDER(s,c,x,y,z);
	input [31:0] a,b;
	input z;
	wire f3,f2,f1;
	output c;
	output [31:0] s;
	
	32BITADDER fadd1(s[7:0],f1,a[7:0],b[7:0],z);
	32BITADDER fadd1(s[15:8],f2,a[15:8],b[15:8],f1);
	32BITADDER fadd1(s[23:16],f3,a[23:16],b[23:16],f2);
	32BITADDER fadd1(s[31:24],c,a[31:24],b[31:24],f3);
	
endmodule

module testbench;
	reg [31:0] x,y
	reg z;
	wire [31:0]s;
	wire c;
	32BITADDER fadd(s[31:0],f1,a[31:0],b[31:0],z);
	initial
	$monitor(,$time,"x=%b,y=%b,z=%b,s=%b,c=%b",x,y,z,s,c);
	initial
		begin
			#0 x=32'b00000000000000000000000000000000;y=32'b00000000000000000000000000000000;z=1'b0;
			repeat(31)
				#2 y=y+ 32'b00000000000000000000000000000001;
		end
endmodule