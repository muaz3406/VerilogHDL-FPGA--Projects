module PR ( Q, D, Clk, rst);
	
	input [5:0] D;
	input Clk, rst;
	output reg [5:0]Q;
	
	always @ ( posedge Clk, posedge rst)
	if (rst) Q <= 5'b0;	//if reset==0, clears the memory
	else Q <= D;

endmodule

module ffd ( Q, D, Clk, rst);
	
	input D;
	input Clk, rst;
	output reg Q;
	
	always @ ( posedge Clk, posedge rst)
	if (rst) Q <= 1'b0;	//if reset==0, clears the memory
	else Q <= D;

endmodule

module half_adder (x, y, s, c);
	
	input x,y;
	output s,c;
	
	xor (s,x,y);
	and (c,x,y);
	
endmodule

module full_adder (s,co,x,y,ci);
	
	input x,y,ci;
	output s,co;
	wire s1,c1,c2;
	
	half_adder hax(x,y,s1,c1);
	half_adder hay(s1,ci,s,c2);
	xor (co,c1,c2);

endmodule

module binary_adder (sum, a, b);
	
	input [3:0] a;
	input [5:0] b;
	output [5:0] sum;
	wire [5:0] c;
	
	//assign out = a+b;
	
	half_adder (a[0],b[0],sum[0],c[0]);
	full_adder (sum[1],c[1],a[1],b[1],c[0]);
	full_adder (sum[2],c[2],a[2],b[2],c[1]);
	full_adder (sum[3],c[3],a[3],b[3],c[2]);
	half_adder (b[4],c[3],sum[4],c[4]);
	half_adder (b[5],c[4],sum[5],c[5]);
	
endmodule

module binary_counter (count, clk, reset);

    input clk, reset;
    output reg [1:0] count;
	 
    always @(posedge clk or posedge reset )
         if (reset) 
              count <= 2'b00;
         else
               count <= count + 2'b01;
endmodule

module isEqual (eq, m, c);
	
	input [1:0] m, c;
	output eq;
	
	assign eq = (m[0]|~c[0])&(m[1]|~c[1])&(~m[0]|c[0])&(~m[1]|c[1]);
	
endmodule

module state_m (r, z, s, clk);
	
	input z, s, clk;
	output r;
	wire a0,b0,da,db;
	
	assign da = ~z & (a0 | b0);
	assign db = ~a0 & ~b0 & s;
	assign r = ~a0 & ~b0 & s;
	
	ffd a(a0, da, clk);
	ffd b(b0, db, clk);
	
	
endmodule

module hw5 (out, z, s, clk, multiplier, multiplicand);
	
	input s, clk;
	input [1:0] multiplier;
	input [3:0] multiplicand;
	output z;
	output [5:0] out;
	wire [5:0] pr;
	wire [1:0] count;
	wire rst;
	
	binary_adder (pr, multiplicand, out);
	PR (out, pr, ~clk, (rst|~s));
	binary_counter (count, ~clk, (rst|~s));
	
	isEqual (z, multiplier, count);

	state_m (rst, z, s, ~clk);
	

endmodule
