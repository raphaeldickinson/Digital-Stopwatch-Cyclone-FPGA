module controlUnit(clk, reset, cw, sw);


	input wire         clk, reset;
	output reg [5:0]   cw;
	input wire [2:0]   sw;

	wire tenth, S1, S2;

	reg 			[3:0] state;
	reg 			[3:0] nextstate;

	localparam   RESET_CW   = 6'b001011;	 
	localparam   STOP_CW    = 6'b000000;
	localparam   S2RES_CW   = 6'b000000;
	localparam   S2R_CW     = 6'b000000;
	localparam   RUN_CW     = 6'b000010;
	localparam   R2LR_CW    = 6'b110000;
	localparam   R2S_CW     = 6'b000000;
	localparam   INC_CW     = 6'b000111;
	localparam   LAPRUN_CW  = 6'b100010;
	localparam   LR2R_CW    = 6'b000000;
	localparam   LR2LS_CW   = 6'b100000;
	localparam   LAPINC_CW  = 6'b100111;
	localparam   LAPSTOP_CW = 6'b100000;
	localparam   LS2R_CW    = 6'b000000;
	localparam   LS2LR_CW   = 6'b100000;
 	 
	
	parameter 	RESET_STATE   = 4'b0000,
					STOP_STATE    = 4'b0001,
					S2RES_STATE   = 4'b0010,
					S2R_STATE     = 4'b0011,
					RUN_STATE     = 4'b0100,
					R2LR_STATE    = 4'b0101,
					R2S_STATE     = 4'b0110,
					INC_STATE     = 4'b0111,
					LAPRUN_STATE  = 4'b1000,
					LR2R_STATE    = 4'b1001,
					LR2LS_STATE   = 4'b1010,
					LAPINC_STATE  = 4'b1011,
					LAPSTOP_STATE = 4'b1100,
					LS2R_STATE    = 4'b1101,
					LS2LR_STATE   = 4'b1110;	
									
					
	assign tenth = sw[0];
	assign S1 = sw[1];
	assign S2 = sw[2];

	 //------------------------------------------
	 // Take care of reset logic
	 //------------------------------------------
	always @(negedge reset, posedge clk)
		if (!reset)
			state <= RESET_STATE;
		else
			state <= nextstate;

	 //------------------------------------------
	 // Determine the output
	 //------------------------------------------
	always @(state) // always block to compute output
		begin
			case(state)

				STOP_STATE:			cw = STOP_CW;
				S2RES_STATE:      cw = S2RES_CW;
				S2R_STATE:        cw = S2R_CW;
				RUN_STATE:        cw = RUN_CW;
				R2LR_STATE:       cw = R2LR_CW;
				R2S_STATE:        cw = R2S_CW;
				INC_STATE:        cw = INC_CW;
				LAPRUN_STATE:     cw = LAPRUN_CW;
				LR2R_STATE:       cw = LR2R_CW;
				LR2LS_STATE:      cw = LR2LS_CW;
				LAPINC_STATE:     cw = LAPINC_CW;
				LAPSTOP_STATE:    cw = LAPSTOP_CW;
				LS2R_STATE:       cw = LS2R_CW;
				LS2LR_STATE:      cw = LS2LR_CW;

				default:				cw = RESET_CW;
			endcase
		end


    //------------------------------------------
	 // Determine the next state
	 //------------------------------------------
	always @(*) // always block to compute nextstate
		begin
			case(state)
			
				STOP_STATE:
					begin
						case({S2,S1})
							2'b10:		nextstate = S2RES_STATE;
							2'b01:		nextstate = S2R_STATE;
							default:		nextstate = STOP_STATE;
						endcase
					end
				
				S2R_STATE:
					begin
						case({S2,S1})
							2'b11:		nextstate = RUN_STATE;
							2'b10:		nextstate = RUN_STATE;
							default:		nextstate = S2R_STATE;
						endcase
					end
					
				RUN_STATE:
					begin
						case({S2,S1, tenth})
							3'b010:		nextstate = R2S_STATE;
							3'b100:		nextstate = R2LR_STATE;
							3'b111:     nextstate = INC_STATE;
							default:		nextstate = RUN_STATE;
						endcase
					end

				R2S_STATE:
					begin
						case({S2,S1})
							2'b10:		nextstate = STOP_STATE;
							2'b11:		nextstate = STOP_STATE;
							default:		nextstate = R2S_STATE;
						endcase
					end

				INC_STATE:
					begin
						nextstate = RUN_STATE;
					end
				
				R2LR_STATE:
					begin
						case({S2,S1})
							2'b11:		nextstate = LAPRUN_STATE;
							2'b01:		nextstate = LAPRUN_STATE;
							default:		nextstate = R2LR_STATE;
						endcase
					end

				LR2R_STATE:
					begin
						case({S2,S1})
							2'b11:		nextstate = RUN_STATE;
							2'b01:		nextstate = RUN_STATE;
							default:		nextstate = LR2R_STATE;
						endcase
					end

				LAPRUN_STATE:
					begin
						case({S2,S1, tenth})
							3'b010:		nextstate = LR2LS_STATE;
							3'b100:		nextstate = LR2R_STATE;
							3'b111:     nextstate = LAPINC_STATE;
							default:		nextstate = LAPRUN_STATE;
						endcase
					end
					
				LAPINC_STATE:        
					begin
						nextstate = LAPRUN_STATE;
					end
					
				LR2LS_STATE:
					begin
						case({S2,S1})
							2'b11:		nextstate = LAPSTOP_STATE;
							2'b10:		nextstate = LAPSTOP_STATE;
							default:		nextstate = LR2LS_STATE;
						endcase
					end

				LAPSTOP_STATE:
					begin
						case({S2,S1})
							2'b10:		nextstate = LS2R_STATE;
							2'b01:		nextstate = LS2LR_STATE;
							default:		nextstate = LAPSTOP_STATE;
						endcase
					end

				LS2LR_STATE:
					begin
						case({S2,S1})
							2'b10:		nextstate = LAPRUN_STATE;
							2'b11:		nextstate = LAPRUN_STATE;
							default:		nextstate = LS2LR_STATE;
						endcase
					end

				LS2R_STATE:
					begin
						case({S2,S1})
							2'b11:		nextstate = RESET_STATE;
							2'b01:		nextstate = RESET_STATE;
							default:		nextstate = LS2R_STATE;
						endcase
					end

				S2RES_STATE:
					begin
						case({S2,S1})
							2'b11:		nextstate = RESET_STATE;
							2'b01:		nextstate = RESET_STATE;
							default:		nextstate = S2RES_STATE;
						endcase
					end

				RESET_STATE:         nextstate = STOP_STATE;
				
				default: 				nextstate = RESET_STATE;
				
			endcase
		end

endmodule
