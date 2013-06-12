`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Copyright (c) 2013 Ian McMahon <imcmahon@prototechnical.com>
//
//////////////////////////////////////////////////////////////////////////////////
module gpmc_sram(
		input			  GPMC_CLK,
		input [15:0]  GPMC_AD_IN,
		output [15:0] GPMC_DATA_OUT,
		input	        GPMC_CS,
		input         GPMC_ADV,
		input			  GPMC_OE,
		input			  GPMC_WE,
		input			  GPMC_BE0,
		input			  GPMC_BE1,
		input			  GPMC_WP,
		input			  GPMC_DIR
);

endmodule
