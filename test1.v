module mux2to1_gate (a,b,s,f); 
	input a,b,s; 
	output f; 
	wire c,d,e; 
 
	not n1(e,s);// e=~s 
	and a1(c,a,s); 
	and a2(d,b,e); 
	or o1(f,c,d); 
endmodule 

module testbench; 
	reg a,b,s; 
	wire f; 
	mux2to1_gate mux_gate (a,b,s,f); 
	initial 
		begin 
			$monitor(,$time," a=%b, b=%b, s=%b f=%b",a,b,s,f); 
			#0 a=1'b0;b=1'b1; 
			#2 s=1'b1; 
			#5 s=1'b0; 
			#10 a=1'b1;b=1'b0; 
			#15 s=1'b1; 
			#20 s=1'b0; 
			#100 $finish;
		end
endmodule
 
 
 
 
 
 
