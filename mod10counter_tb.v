
module mod10counter_tb;

	reg	t_clk, t_resetn, t_enb, t_synch;
	wire	t_roll;
	wire	[3:0]  t_currentCount;

	mod10counter uut (t_clk, t_resetn, t_enb, t_synch, t_roll, t_currentCount);

	initial
		begin

			t_enb = 1'b0;	t_synch = 1'b0;

			t_resetn = 0;			#5
			t_resetn = 1;			#10

			t_enb		= 1'b1;		#180
			t_enb		= 1'b0;		#20
			t_enb		= 1'b1;		#40
			t_enb		= 1'b0;		#20

			t_synch	= 1'b1;		#20
			t_synch	= 1'b0;		t_enb		= 1'b1;

		 end

	//---------------------------
	// Generate a clock signal with period 20ns
	//---------------------------
	always // no sensitivity list, so it always executes
		begin
			t_clk = 1;			#10;
			t_clk = 0;			#10;
		end


endmodule
