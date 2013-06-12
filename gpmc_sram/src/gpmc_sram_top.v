`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:55:04 06/12/2013 
// Design Name: 
// Module Name:    gpmc_sram_top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module gpmc_sram_top(
		input			  GPMC_CLK,
		inout [15:0]  GPMC_AD,
		input	        GPMC_CS,
		input         GPMC_ADV,
		input			  GPMC_OE,
		input			  GPMC_WE,
		input			  GPMC_BE0,
		input			  GPMC_BE1,
		input			  GPMC_WP,
		input			  GPMC_DIR
);

wire gpmc_ad_in;
reg  gpmc_ad_out;

wire a_clk;
wire a_ena;
wire a_wr;
wire [10:0] a_addr;
wire [15:0] a_din;
wire [15:0] a_dout;

IOBUF #(
   .DRIVE(12), // Specify the output drive strength
   .IBUF_DELAY_VALUE("0"),   // Specify the amount of added input delay for the buffer, "0"-"16" (Spartan-3A only)
   .IFD_DELAY_VALUE("AUTO"), // Specify the amount of added delay for input register,  "AUTO", "0"-"8" (Spartan-3A only)
   .IOSTANDARD("DEFAULT"), // Specify the I/O standard
   .SLEW("SLOW") // Specify the output slew rate
) IOBUF_gpmc_ad[15:0] (
   .O(gpmc_ad_in),  	// Buffer output
   .IO(GPMC_AD),		// Buffer inout port (connect directly to top-level port)
   .I(gpmc_ad_out),	// Buffer input
   .T(~GPMC_DIR)    	// 3-state enable input, high=input, low=output
);
  
bram2k_x_16bit bram (
	.a_clk(a_clk),
	.a_wr(a_wr),
	.a_ena(a_ena),
	.a_addr(a_addr),
	.a_din(a_din),
	.a_dout(a_dout)
);
  
gpmc_sram_controller sram_controller (
		.GPMC_CLK(GPMC_CLK),
		.GPMC_AD_IN(gpmc_ad_in),
		.GPMC_DATA_OUT(gpmc_ad_out),
		.GPMC_CS(GPMC_CS),
		.GPMC_ADV(GPMC_ADV),
		.GPMC_OE(GPMC_OE),
		.GPMC_WE(GPMC_WE),
		.GPMC_BE0(GPMC_BEO),
		.GPMC_BE1(GPMC_BE1),
		.GPMC_WP(GPMC_WP),
		.GPMC_DIR(GPMC_DIR),

		.a_ena(a_ena),
		.a_wr(a_wr),
		.a_addr(a_addr),
		.a_din(a_din),
		.a_dout(a_dout)
);

endmodule
