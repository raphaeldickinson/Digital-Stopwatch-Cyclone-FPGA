module controlUnit_tb;

   parameter SW_VECTOR_LENGTH	= 3;
   parameter CW_VECTOR_LENGTH	= 6;

	reg t_clk, t_reset;
	wire [CW_VECTOR_LENGTH - 1 : 0] t_cw;
	wire [SW_VECTOR_LENGTH - 1 : 0] t_sw;

	reg tenth, S1, S2;

	controlUnit uut (t_clk, t_reset, t_cw, t_sw);

	assign t_sw[0] = tenth;
	assign t_sw[1] = S1;
	assign t_sw[2] = S2;

	initial
		begin

			tenth = 0;	S1 = 1;		S2 = 1;

			t_reset = 0;		#5
			t_reset = 1;		#10

			#40

			$display("Button S2 pressed.");
			S2 = 0;							#20
			S2 = 1;	tenth = 0;			#40
			tenth = 1;						#20
			tenth = 0;						#40
			tenth = 1;						#20
			tenth = 0;						#40
			tenth = 1;						#20
			tenth = 0;						#20

			$display("Button S1 pressed.");
			S1 = 0;							#40
			S1 = 1;	tenth = 0;			#40
			tenth = 1;						#20
			tenth = 0;						#40
			tenth = 1;						#20
			tenth = 0;						#40
			tenth = 1;						#20
			tenth = 0;						#20

			$display("Button S2 pressed.");
			S2 = 0;				#40
			S2 = 1;				#20

			$display("Button S2 pressed.");
			S2 = 0;				#40
			S2 = 1;				#20

			$display("Button S1 pressed.");
			S1 = 0;				#40
			S1 = 1;				#20

			$display("Button S2 pressed.");
			S2 = 0;				#40
			S2 = 1;				#20

			$display("Button S1 pressed.");
			S1 = 0;				#40
			S1 = 1;

		 end

	 //---------------------------
	 // Generate a clock signal with period 20ns
	 //---------------------------
	always // no sensitivity list, so it always executes
		begin
			t_clk = 1; 		#10;
			t_clk = 0;	   #10;
		end


endmodule
