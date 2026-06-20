//------------------------------------------
//	Name:	Chris Coulston
// Date:	Spring 2020
// File:	genericMux2x1
//	Purp:	Select one of two N-bit values on output
//------------------------------------------
//------------------------------------------
module mod10counter(clk, resetn, enb, synch, roll, currentCount);
	
	input wire clk;
	input wire resetn;
	input wire enb;
	input wire synch;
	output reg roll;
	output wire [3:0] currentCount;
	reg muxSel, regEnb;
	wire eq9;
	wire [3:0] sum, muxOut;
	
	always @(*)
		casez ({enb, synch, eq9})
			3'b000: {muxSel, regEnb, roll} = 3'b?00;
			3'b001: {muxSel, regEnb, roll} = 3'b?00;
			3'b010: {muxSel, regEnb, roll} = 3'b010;
			3'b011: {muxSel, regEnb, roll} = 3'b010;
			3'b100: {muxSel, regEnb, roll} = 3'b110;
			3'b101: {muxSel, regEnb, roll} = 3'b011;
			3'b110: {muxSel, regEnb, roll} = 3'b010;
			3'b111: {muxSel, regEnb, roll} = 3'b010;
		endcase
		
	genericComparator #(4) eq9c(currentCount, 4'b1001, , eq9,);
	
	genericAdder #(4) incrementer(4'b0001, currentCount, 4'b0000, sum,);

	genericMux2x1 #(4) zeroOrIncrement(sum, 4'b0000, muxSel, muxOut);
	
	genericRegister #(4) register(clk, resetn, muxOut, regEnb, currentCount);
	
endmodule
	
		
	