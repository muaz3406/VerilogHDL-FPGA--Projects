module hw2 (owf,a0,b0,c0,d0,e0,f0,g0, a1,b1,c1,d1,e1,f1,g1, a2,b2,c2,d2,e2,f2,g2, i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11);
	
	input i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11;
	output owf, a0,b0,c0,d0,e0,f0,g0, a1,b1,c1,d1,e1,f1,g1, a2,b2,c2,d2,e2,f2,g2;
	wire car0,car1,o0,o1,o2,o3,o4,o5,o6,o7,o8,o9,o10,o11;
	
	four_bit_adder (o3,o2,o1,o0,car0,i3,i2,i1,i0,1);
	four_bit_adder (o7,o6,o5,o4,car1,i7,i6,i5,i4,car0);
	four_bit_adder (o11,o10,o9,o8,owf,i11,i10,i9,i8,car1);
	
	segment (a0,b0,c0,d0,e0,f0,g0,o3,o2,o1,o0);
	segment (a1,b1,c1,d1,e1,f1,g1,o7,o6,o5,o4);
	segment (a2,b2,c2,d2,e2,f2,g2,o11,o10,o9,o8);
	
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

module four_bit_adder (a,b,c,d,carryout,x,y,z,t,carryin);

	input x,y,z,t,carryin;
	output a,b,c,d,carryout;
	wire k0,k1,k2,k3,m0,m1,m2,m3;
	
	half_adder (k0,m0,t,carryin);
	half_adder (k1,m1,z,m0);
	half_adder (k2,m2,y,m1);
	half_adder (k3,m3,x,m2);
	
	assign carryout = k3 & ~k2 & k1 & ~k0;
	assign a = k3 & ~carryout;
	assign b = k2 & ~carryout;
	assign c = k1 & ~carryout;
	assign d = k0 & ~carryout;

endmodule

module half_adder (s, c, x, y);
	
	input x,y;
	output s,c;
	
	xor (s,x,y);
	and (c,x,y);
	
endmodule
