`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
//
// Copyright (c) 2013 Ian McMahon <imcmahon@prototechnical.com>
// 
////////////////////////////////////////////////////////////////////////////////

module sync_single_read_tb;

	reg fclk;
	reg clk;
	
	reg clk_en;
	reg be0;
	reg be1;
	reg cs;
	reg adv;
	reg oe;
	reg dir;

	reg [15:0] ad_in;
	wire [15:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	gpmc_sram uut (
		.GPMC_CLK(clk),
		.GPMC_AD_IN(ad_in),
		.GPMC_DATA_OUT(data_out),
		.GPMC_CS(cs),
		.GPMC_ADV(adv),
		.GPMC_DIR(dir),
		.GPMC_OE(oe),
		.GPMC_BE0(be0),
		.GPMC_BE1(be1),
		.GPMC_WP(0)
	);

	initial begin
		// Initialize Inputs
		fclk = 1;
		clk = 0;
		clk_en = 0;
	
		
		dir = 0; // 0 master out, 1 master in
		adv = 1; // active low
		oe  = 1; // active low
		be0 = 1; // active low
		be1 = 1; // active low
		cs = 1;  // active low
		
		
		// Wait 40 ns for global reset to finish
		#40;
      
		// select address 0x0000
		ad_in = 16'h0000;
		
		// enable GPMC_CLK
		#10 clk_en = 1;
		
		// enable CS and ADV/ALE for two periods of CLK
		#10 cs = 0;
		adv = 0;
		
		#20 adv = 1;
		
		// after two more periods, assert dir = IN and output enable
		#20 dir = 1;
		oe = 0;
		
		// kill clock
		#30 clk_en = 0;
		
		// dir back to in
		#10 dir = 0;
		oe = 1;
		cs = 1;
		
	end
      
	always begin 
		#5 fclk <= ~fclk;
		clk <= ~fclk & clk_en;
	end
endmodule

