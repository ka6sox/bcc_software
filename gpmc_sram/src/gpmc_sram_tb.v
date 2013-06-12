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

	// Bidirs
	wire [15:0] GPMC_AD;

	// Instantiate the Unit Under Test (UUT)
	gpmc_sram uut (
		.GPMC_AD(GPMC_AD)
	);

	initial begin
		// Initialize Inputs

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

