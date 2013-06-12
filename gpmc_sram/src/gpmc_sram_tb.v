`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:13:35 06/12/2013
// Design Name:   gpmc_sram
// Module Name:   Z:/beagle/bcc_software/gpmc_sram/src/gpmc_sram_tb.v
// Project Name:  gpmc_sram
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: gpmc_sram
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module gpmc_sram_tb;

	reg fclk;
	reg clk;
	
	reg clk_en;
	reg be0;
	reg be1;
	reg cs;
	reg adv;
	reg oe;
	reg dir;

	// Bidirs
	wire [15:0] ad;

	wire [15:0] ad_fromram;
	reg  [15:0] ad_toram;

	assign ad = (dir) ? ad_toram : ad_fromram;

	// Instantiate the Unit Under Test (UUT)
	gpmc_sram uut (
		.GPMC_CLK(clk),
		.GPMC_AD(ad),
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
		
		
		
		// Wait 40 ns for global reset to finish
		#40;
      
		// select address 0x0000
		ad_toram = 16'h0000;
		#10 clk_en = 1;
		
	end
      
	always begin 
		#5 fclk <= ~fclk;
		clk <= ~fclk & clk_en;
	end
endmodule

