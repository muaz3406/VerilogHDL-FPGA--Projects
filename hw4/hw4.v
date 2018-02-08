module hw4 (out, address, data, en, wr, clk);
	
	input [1:0] address;
	input [7:0] data;
	input en, wr, clk;
	output [7:0] out;
	
	four_byte_memory (out, address, data, en, wr, clk);
	
endmodule

module mux (out, I0,I1,I2,I3, sel);
	
	input [7:0] I0;
	input [7:0] I1;
	input [7:0] I2;
	input [7:0] I3;
	input [1:0] sel;
	output reg [7:0] out;
	
	always @(I0,I1,I2,I3 or sel)
	case (sel)
		2'b00: out = I0;
		2'b01: out = I1;
		2'b10: out = I2;
		2'b11: out = I3;
		default : out = 8'b0000000;
	endcase
	
endmodule

module demux (clk_o, clk_in, address);
	
	input clk_in;
	input [1:0] address;
	output reg [3:0] clk_o;
	reg [3:0] clk_o0;
	
	always @ (address)
	case (address)
		2'b00: clk_o0 = 4'b0001;
		2'b01: clk_o0 = 4'b0010;
		2'b10: clk_o0 = 4'b0100;
		2'b11: clk_o0 = 4'b1000;
		default : clk_o0 = 4'b0000;
	endcase
	
	always @ (clk_in)
	if(clk_in == 1)
		clk_o = clk_o0;
	else
		clk_o = 4'b0000;
	
endmodule

module D_FF (Q, D, Clk);
	output Q;
	input D, Clk;
	reg Q;
	always @ ( posedge Clk)
		Q <= D;
endmodule

module one_byte_memory (dout, din, clk);
	
	input [7:0] din;
	input clk;
	output [7:0] dout;
	
	D_FF (dout[0], din[0], clk);
	D_FF (dout[1], din[1], clk);
	D_FF (dout[2], din[2], clk);
	D_FF (dout[3], din[3], clk);
	D_FF (dout[4], din[4], clk);
	D_FF (dout[5], din[5], clk);
	D_FF (dout[6], din[6], clk);
	D_FF (dout[7], din[7], clk);
	
endmodule

module four_byte_memory (out, address, data, en, wr, clk);
	
	input [1:0] address;
	input [7:0] data;
	input en, wr, clk;
	output [7:0] out;
	wire [7:0] outx;
	wire [7:0] out0;
	wire [7:0] out1;
	wire [7:0] out2;
	wire [7:0] out3;
	wire clk0;
	wire [3:0] c0;
	
	and (clk0, clk, wr, en); //if en!=1 & wr !=1, cannot change the value
	
	demux (c0, clk0, address);
	
	one_byte_memory (out0, data, c0[0]);
	one_byte_memory (out1, data, c0[1]);
	one_byte_memory (out2, data, c0[2]);
	one_byte_memory (out3, data, c0[3]);
	
	mux (outx, out0,out1,out2,out3, address);
	
	and (out, outx, ~wr, en);
	
endmodule
