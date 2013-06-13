`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Copyright (c) 2013 Ian McMahon <imcmahon@prototechnical.com>
//
//////////////////////////////////////////////////////////////////////////////////
module gpmc_sram_controller(
		input			  GPMC_CLK,
		input [15:0]  GPMC_AD_IN,
		output reg [15:0] GPMC_DATA_OUT,
		input	        GPMC_CS,
		input         GPMC_ADV,
		input			  GPMC_OE,
		input			  GPMC_WE,
		input			  GPMC_BE0,
		input			  GPMC_BE1,
		input			  GPMC_WP,
		input			  GPMC_DIR,

		output reg			a_ena,
		output reg			a_wr,
		output reg [10:0]	a_addr,
		output reg [15:0] a_din,
		input wire [15:0] a_dout
);

initial begin
	a_ena = 0;
	a_wr = 0;
	a_din = 16'h0000;
	a_addr = 10'h000;
end


always @(posedge GPMC_CLK) begin
	if(~GPMC_ADV) a_addr <= GPMC_AD_IN;

	a_ena <= ~GPMC_CS;

	GPMC_DATA_OUT <= a_dout;
end


endmodule
