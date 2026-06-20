module datapath(clk, reset, cw, tenth, tenHex, unitHex, tenthHex);

   parameter N = 24;			// Adjust the length to accomodiate the localparam defined below
   input wire	clk, reset;
	input wire  [5:0] cw;
	output wire tenth;
	
	// Make sure to include the other parameters here
	
	output [6:0] tenthHex, unitHex, tenHex;
	wire [3:0] tenthDisp, unitDisp, tenDisp, qTenthReg, qUnitReg, qTenReg, tenthDigit, unitDigit, tenDigit;
	wire unitRoll, tenthRoll;
	wire [N-1:0]  clkCount;

	// You cannot put "N" as the length specifier for constants.
	// So you will need to update the length specifier to be consistent
	// with the value of the parameter N defined above.
	localparam   tenthSecondConstant   = 24'h4c4b40;
   localparam   zero24 = 24'h000000;
	//localparam   tenthSecondConstant   = 4'h000002;
   //localparam   zero24 = 4'h000000;

	genericCounter    #(N) tenthSecondCounter(clk, reset, zero24, cw[1:0], clkCount);
   genericComparator #(N) tenthSecondCompare(clkCount, tenthSecondConstant, , tenth);

	// Need to instantiate the other components here
	
	mod10counter tenthMod10Counter(clk, reset, cw[2], cw[3], tenthRoll, tenthDigit);
	mod10counter unitMod10Counter(clk, reset, tenthRoll, cw[3], unitRoll, unitDigit);
	mod10counter tenMod10Counter(clk, reset, unitRoll, cw[3], , tenDigit);
	
	genericRegister #(4) tenthReg(clk, reset, tenthDigit, cw[4], qTenthReg);
	genericRegister #(4) unitReg(clk, reset, unitDigit, cw[4], qUnitReg);
	genericRegister #(4) tenReg(clk, reset, tenDigit, cw[4], qTenReg);
	
	genericMux2x1 #(4) tenthMux(qTenthReg, tenthDigit, cw[5], tenthDisp);
	genericMux2x1 #(4) unitMux(qUnitReg, unitDigit, cw[5], unitDisp);
	genericMux2x1 #(4) tenMux(qTenReg, tenDigit, cw[5], tenDisp);
	
	hexToSevenSeg tenthDispHex(tenthDisp, tenthHex);
	hexToSevenSeg unitDispHex(unitDisp, unitHex);
	hexToSevenSeg tenDispHex(tenDisp, tenHex);

endmodule
