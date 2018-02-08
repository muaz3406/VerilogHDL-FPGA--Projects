module hw3 (a,b,c,d,e,f,g, i0,i1,i2,i3,i4,i5,i6,i7);
	
	input i0,i1,i2,i3,i4,i5,i6,i7;
	output a,b,c,d,e,f,g;
	wire d0,d1,d2,d3,d4,d5,d6, w0,w1,w2,w3, num0,num1,num2,num3;
	
	////////////////-- determining the range of input --///////
	eight_bit_comparator (w0,d0,w1, i0,i1,i2,i3,i4,i5,i6,i7, 0,1,1,1,1,1,1,1);	// 127 = 1,5V
	eight_bit_comparator (d4,d3,w2, i0,i1,i2,i3,i4,i5,i6,i7, 1,1,0,1,0,1,0,0);	// 212 = 2,5V
	eight_bit_comparator (w3,d5,d6, i0,i1,i2,i3,i4,i5,i6,i7, 0,0,1,0,1,0,1,0);	// 42 = 0,5V
	
	and (d1, w0,w2);
	and (d2, w1,w3);
	
	///////////////-- determining the numbers --///////////////
	assign num0 = d6;
	assign num1 = d5 | d2;
	assign num2 = d0 | d1;
	assign num3 = d3 | d4;
	
	///////////////-- writing to sevensegment --///////////////
	assign a = num1;
	assign b = 0;
	assign c = num2;
	assign d = num1;
	assign e = num3 | num1;
	assign f = num1 | num2 | num3;
	assign g = num1 | num0;
	
endmodule

module multiplexer (f, d0,d1,d2,d3, b1,b0);
	
	input d0,d1,d2,d3;
	input b1,b0;
	output f;
	wire o1,o2,o3,o4,nb0,nb1;
	
	not (nb0, b0);
	not (nb1, b1);
	
	and (o1, d0, nb1, nb0);
	and (o2, d1, nb1, b0);
	and (o3, d2, b1, nb0);
	and (o4, d3, b1, b0);
	
	or (f, o1, o2, o3, o4);
	
	
endmodule

module grater_comparator (f, a1,a0, b1,b0);
	
	input a1,a0, b1,b0;
	output f;
	wire f0,f1,f2,f3;
	
	////////////-- combining four of the multiplexers --///////////////////
	multiplexer (f0, 0,0,0,0, b1,b0);
	multiplexer (f1, 1,0,0,0, b1,b0);
	multiplexer (f2, 1,1,0,0, b1,b0);
	multiplexer (f3, 1,1,1,0, b1,b0);
	
	assign f = (f0&(~a1&~a0)) | (f1&(~a1&a0)) | (f2&(a1&~a0)) | (f3&(a1&a0));
	
endmodule

module equal_comparator (f, a1,a0, b1,b0);
	
	input a1,a0, b1,b0;
	output f;
	wire f0,f1,f2,f3;
	
	////////////-- combining four of the multiplexers --///////////////////
	multiplexer (f0, 1,0,0,0, b1,b0);
	multiplexer (f1, 0,1,0,0, b1,b0);
	multiplexer (f2, 0,0,1,0, b1,b0);
	multiplexer (f3, 0,0,0,1, b1,b0);
	
	assign f = (f0&(~a1&~a0)) | (f1&(~a1&a0)) | (f2&(a1&~a0)) | (f3&(a1&a0));
	
endmodule

module less_comparator (f, a1,a0, b1,b0);
	
	input a1,a0, b1,b0;
	output f;
	wire f0,f1,f2,f3;
	
	////////////-- combining four of the multiplexers --///////////////////
	multiplexer (f0, 0,1,1,1, b1,b0);
	multiplexer (f1, 0,0,1,1, b1,b0);
	multiplexer (f2, 0,0,0,1, b1,b0);
	multiplexer (f3, 0,0,0,0, b1,b0);
	
	assign f = (f0&(~a1&~a0)) | (f1&(~a1&a0)) | (f2&(a1&~a0)) | (f3&(a1&a0));
	
endmodule

module two_bit_comparator (G,E,L, a1,a0, b1,b0, Ig,Ie,Il);
	
	input a1,a0, b1,b0, Ig,Ie,Il;
	output G,E,L;
	wire nIg,nIl, l0,l1, g0,g1, e0;
	
	not (nIg,Ig);
	not (nIl,Il);
	
	///////////-- comparing two-bit numbers --//////////////
	grater_comparator (g0, a1,a0, b1,b0);
	equal_comparator (e0, a1,a0, b1,b0);
	less_comparator (l0, a1,a0, b1,b0);
	
	and (g1,g0,nIl);
	or (G,g1,Ig);
	
	and (E,e0,Ie);
	
	and (l1,l0,nIg);
	or (L,l1,Il);
	
endmodule

module eight_bit_comparator (G,E,L, a0,a1,a2,a3,a4,a5,a6,a7, b7,b6,b5,b4,b3,b2,b1,b0);
	
	input a0,a1,a2,a3,a4,a5,a6,a7;
	input b0,b1,b2,b3,b4,b5,b6,b7;
	output G,E,L;
	wire g0,g1,g2, e0,e1,e2, l0,l1,l2;
	
	////////////-- comparing eight-bit numbers, two-bit by two-bit --//////////////
	two_bit_comparator (g0,e0,l0, a7,a6, b7,b6, 0,1,0);
	two_bit_comparator (g1,e1,l1, a5,a4, b5,b4, g0,e0,l0);
	two_bit_comparator (g2,e2,l2, a3,a2, b3,b2, g1,e1,l1);
	two_bit_comparator (G,E,L,  a1,a0, b1,b0, g2,e2,l2);
	
endmodule
