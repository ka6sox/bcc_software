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

	reg [15:0] ad;

	wire [10:0] a_addr;
	wire [15:0] a_din;
	wire [15:0] a_dout;
	wire a_wr;
	wire a_ena;
	
	
	gpmc_sram_top top_under_test (
		.GPMC_CLK(clk),
		.GPMC_AD(ad),
		.GPMC_CS(cs),
		.GPMC_ADV(adv),
		.GPMC_DIR(dir),
		.GPMC_OE(oe),
		.GPMC_BE0(be0),
		.GPMC_BE1(be1),
		.GPMC_WP(1'b0)
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
		ad = 16'h001F;
		
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
		#35 clk_en = 0;
		
		// dir back to in
		#5 dir = 0;
		oe = 1;
		cs = 1;
		
	end
      
	always begin 
		#5 fclk <= ~fclk;
		clk <= ~fclk & clk_en;
	end
endmodule

