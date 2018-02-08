module project(calling_status,door,enable,reset,floor_status,clk,a0,a1,a2,a3,a4,a5,a6);

	input [1:0] calling_status;
	input enable,reset,clk; 
	output [1:0] floor_status;
	output door,a0,a1,a2,a3,a4,a5,a6;
	wire door;
	wire g,e,l;
	reg startup,startdown,startequal;
	
	comparator compare(calling_status,floor_status,g,e,l);
	
	always @ (posedge clk)
	begin	: control_block	
		if(g==1'b1) begin
			startup<=1'b1;
		end
		else begin
			startup<=1'b0;
		end
		if(e==1'b1) begin
			startequal<=1'b1;
		end
		else begin
			startequal<=1'b0;
		end
		if(l==1'b1) begin
			startdown<=1'b1;
		end
		else begin
			startdown<=1'b0;
		end
	end	
	assign door=startequal;
	countupdown updown(floor_status,startup,startdown,startequal,clk);
	segment(a0,a1,a2,a3,a4,a5,a6,0,0,floor_status[1],floor_status[0]);
	
endmodule

module countupdown(cd,g,l,e,clk);
    input g,l,e,clk;
    output reg [1:0] cd;	 

	 always @ (negedge clk)
	 begin
	 if(e==1'b0) begin
		if(g==1'b1) begin	
			if(cd<=2'b11) begin
				cd<=cd+1;
			end
		end
		if(l==1'b1) begin
			if(cd>=2'b00) begin				
				cd<=cd-1;
			end
		end
	 end
	 end
endmodule

module full_adder (x,y,ci,s,co);
	
	input x,y,ci;
	output s,co;
	wire s1,c1,c2;
	
	half_adder hax(x,y,s1,c1);
	half_adder hay(s1,ci,s,c2);
	xor (co,c1,c2);

endmodule

module half_adder (s, c, x, y);	
	input x,y;
	output s,c;
	
	xor (s,x,y);
	and (c,x,y);
	
endmodule

module comparator1(A, B, GT, EQU, LT);

input [1:0] A;
input [1:0] B;

output GT;//when a is greater than b
output EQU;//when a is equal to b
output LT;//when a is less than b

//Boolean Output Descriptions

assign  GT =    A[1]&~B[1] 
          | ~A[1]&A[0]&~B[1]&~B[0] 
          | A[1]&~A[0]&B[1]&B[0];


assign  EQU =    ~A[1]&~A[0]&~B[1]&~B[0] 
           | ~A[1]&A[0]&~B[1]&B[0] 
           | A[1]&A[0]&B[1]&B[0] 
           | A[1]&~A[0]&B[1]&~B[0];


assign  LT =    ~A[1]&B[1] 
          | ~A[1]&~A[0]&B[0] 
          | ~A[0]&B[1]&B[0];

endmodule

module comparator( a ,b ,greater ,equal,lower );

output equal ;
output greater ;
output lower ;

input [1:0] a ;
input [1:0] b ;


assign equal = (a==b) ? 1 : 0;
assign greater = (a>b) ? 1 : 0;
assign lower = (a<b) ? 1 : 0;

endmodule

module ff(in,out,clk);

	input in,clk;
	output reg out;

	always @(posedge clk)begin
		out<=in;
	end
endmodule

module segment(a,b,c,d,e,f,g,A,B,C,D);
	
	input A,B,C,D;
	output a,b,c,d,e,f,g;
	
	assign a = (!A&!B&!C&D)|(!A&B&!C&!D);
	assign b = (!A&B&!C&D)|(!A&B&C&!D);
	assign c = (!A&!B&C&!D);
	assign d = (!A&!B&!C&D)|(!A&B&!C&!D)|(!A&B&C&D);
	assign e = (!A&D)|(!B&!C&D)|(!A&B&!C);
	assign f = (!A&!B&D)|(!A&!B&C)|(!A&C&D);
	assign g = (!A&!B&!C)|(!A&B&C&D);
	
endmodule
