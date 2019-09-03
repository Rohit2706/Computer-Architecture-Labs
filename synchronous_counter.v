module JKFlipFlop(j,k,clock, q);
	input j,k, clock;
	output q;
	reg q;
	initial
	q=0;
	
	always @ (posedge clock)
	begin
		q <= (j & ~q) | (~k & q);
	end
endmodule

// for JK flip flop
/*module Testing;
	reg j,k, clk, rst;
	wire q;
	JKFlipFlop jk (j,k, clk, q);
	
	always @(posedge clk)begin
		$display("j=%b, k=%b, clk=%b, q=%b\n", j,k, clk, q);
	end

	initial begin
	repeat(20)
	begin
		#5 clk=0;
		#5 clk=1;
	end
	end
	initial begin
		#0 j=1'b0; k=1'b0;
		#10 j=1'b0;k=1'b1; 
		#20 j=1'b1;k=1'b0; 
		#30 j=1'b1; k=1'b1; 
	end
endmodule*/

module synchronous_counter(clock,q0,q1,q2,q3);
	input clock;
	output q0,q1,q2,q3;
	wire a,b;
	JKFlipFlop jk1 (1'b1,1'b1, clock, q0);
	JKFlipFlop jk2 (q0,q0, clock, q1);
	and(a,q0,q1);
	JKFlipFlop jk3 (a,a, clock, q2);
	and(b,q2,a);
	JKFlipFlop jk4 (b,b, clock, q3);
endmodule
	
module test;
	reg clock;
	wire q0,q1,q2,q3;
	synchronous_counter sq(clock,q0,q1,q2,q3);
	
	always @(posedge clock)begin
		$display("%b%b%b%b",q3,q2,q1,q0);
	end
	
	initial begin
	repeat(16)
	begin
		#5 clock=0;
		#5 clock=1;
	end
	end
endmodule
	