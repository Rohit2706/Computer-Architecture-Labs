module magcompare(c,a,b); 
	input [3:0]a, [3:0]b;
	output [2:0]c;
	always@(a or b or c)
		if(a[3]>b[3])
			
endmodule 

module testbench; 
	reg [3:0]a, [3:0]b;
	wire [2:0]f;
	initial 
		begin 
			$monitor(,$time," a=%4b, b=%4b, f=%3b",a,b,f); 
			#0 a=4'b0000;b=4'b0000; 
			repeat(16)
				#2 b = b + 4'b0001;
			#100 $finish;
		end
endmodule
 
 
 
 
 
 
