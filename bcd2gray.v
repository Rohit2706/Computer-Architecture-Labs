module bcd2gray(o,i);
    output [3:0]o;
    input [3:0]i;
    assign o[0] = i[0]^i[1];
	assign o[1] = i[1]^i[2];
	assign o[2] = i[2]|i[3];
	assign o[3] = i[3];
endmodule

module testbench; 
	reg [3:0]a; 
	wire [3:0]f; 
	bcd2gray bcd(f,a);
	initial 
		begin 
			$monitor(,$time," a=%4b, f=%4b",a,f); 
			#0 a=4'b0000;
			repeat(9)
			begin
				#10 a = a + 4'b0001;
			end
			#10 $finish;
		end
		
	initial  
		begin  
			$dumpfile("file.vcd"); 
			$dumpvars; 
		end 
endmodule