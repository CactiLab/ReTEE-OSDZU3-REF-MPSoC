/*************************************************************************
 * Copyright 2021, DesignLinx Hardware Solutions, Inc.
 * <www.designlinxhs.com>
 * All Rights Reserved
 *
 * This is unpublished proprietary information of DesignLinx Hardware
 * Solutions, Inc. This copyright notice does not evidence publication.
 *
 * The use of the software (Verilog, VHDL, C, C++, Scripts, etc.),
 * documentation, methodologies, and other information contained herein
 * is governed solely by the associated license agreements. Any inconsistent
 * use shall be deemed to be a misappropriation of the intellectual property
 * of DesignLinx Hardware Solutions, Inc.
 *************************************************************************/
 
 /************************************************************************
  *
  * File:		lvds_display_tx.v
  * Author:		Ted Booth
  * Date:		Oct. 11, 2021
  * Descrition:	LVDS Display Tx IP implementation for UltraScale+
  *
  ************************************************************************/
`timescale 1ps/1ps

module lvds_display_tx #(
    parameter         PIXEL_FORMAT = "RGB",     // Data Format - RGB or RBG
	parameter	      USE_ALPHA = 3,            // Number of bytes per Pixel
	parameter real    CLKIN_PERIOD = 12.5,      // Clock period (ns) of input clock on clkin_p
    parameter         USE_PLL = "FALSE",        // Enable PLL use rather than MMCM use
    parameter         CLK_PATTERN = 7'b1100011, // Clock Pattern for Synchronization
    parameter         TX_SWAP_MASK = 16'b0      // Allows P/N inputs to be invered to ease PCB routing
   )
   (
      input                   ref_clk,     // Reference Clock input - Tx Data frequency (~80 MHz)
      input                   reset,       // Asynchronous interface reset
      output                  cmt_locked,  // PLL/MMCM locked output
      output                  px_clk,      // Pixel clock output

      input [(8*USE_ALPHA)-1:0]  vid_io_in,     // Pixel Data
      input                   vid_active_video, // Pixel Valid
      input                   vid_hsync,        // Horizontal Sync
      input                   vid_vsync,        // Vertical Sync
      
      output                   clkout_p,     // Clock output LVDS P-side
      output                   clkout_n,     // Clock output LVDS N-side
      output  [3:0]            dataout_p,    // Data output LVDS P-side
      output  [3:0]            dataout_n    // Data output LVDS N-side
   );

//    wire            px_clk;
    wire            clkdiv2;
    wire            clkdiv4;
    wire            locked;
    
    reg      [3:0]  px_locked;
    wire            px_reset;
    
    reg[(8*USE_ALPHA)-1:0]  vid_io_r;
	reg                  vid_av_r;
	reg                  vid_hs_r;
	reg                  vid_vs_r;

    wire [27:0] px_data;
    
    always @ (posedge ref_clk) begin
		vid_io_r <= vid_io_in;
		vid_av_r <= vid_active_video;
		vid_hs_r <= vid_hsync;
		vid_vs_r <= vid_vsync;
	end

    
    if(PIXEL_FORMAT == "RGB") begin    
    	// Map to the RGB Format
        assign px_data[0]  = vid_io_r[8];  // G0
        assign px_data[1]  = vid_io_r[1];  // B1
        assign px_data[2]  = vid_av_r;
        assign px_data[3]  = 1'b0;
        assign px_data[4]  = vid_io_r[21]; // R5
        assign px_data[5]  = vid_io_r[0];  // B0
        assign px_data[6]  = vid_vs_r;
        assign px_data[7]  = vid_io_r[7];  // B7
        assign px_data[8]  = vid_io_r[20]; // R4
        assign px_data[9]  = vid_io_r[13]; // G5
        assign px_data[10] = vid_hs_r;
        assign px_data[11] = vid_io_r[6];  // B6
        assign px_data[12] = vid_io_r[19]; // R3
        assign px_data[13] = vid_io_r[12]; // G4
        assign px_data[14] = vid_io_r[5];  // B5
        assign px_data[15] = vid_io_r[15]; // G7
        assign px_data[16] = vid_io_r[18]; // R2
        assign px_data[17] = vid_io_r[11]; // G3
        assign px_data[18] = vid_io_r[4];  // B4
        assign px_data[19] = vid_io_r[14]; // G6
        assign px_data[20] = vid_io_r[17]; // R1
        assign px_data[21] = vid_io_r[10]; // G2
        assign px_data[22] = vid_io_r[3];  // B3
        assign px_data[23] = vid_io_r[23]; // R7
        assign px_data[24] = vid_io_r[16]; // R0
        assign px_data[25] = vid_io_r[9];  // G1
        assign px_data[26] = vid_io_r[2];  // B2
        assign px_data[27] = vid_io_r[22]; // R6
    end
    else begin
		// Map to the RBG Format
        assign px_data[0]  = vid_io_r[0];  // G0
        assign px_data[1]  = vid_io_r[9];  // B1
        assign px_data[2]  = vid_av_r;
        assign px_data[3]  = 1'b0;
        assign px_data[4]  = vid_io_r[21]; // R5
        assign px_data[5]  = vid_io_r[8];  // B0
        assign px_data[6]  = vid_vs_r;
        assign px_data[7]  = vid_io_r[15]; // B7
        assign px_data[8]  = vid_io_r[20]; // R4
        assign px_data[9]  = vid_io_r[5];  // G5
        assign px_data[10] = vid_hs_r;
        assign px_data[11] = vid_io_r[14]; // B6
        assign px_data[12] = vid_io_r[19]; // R3
        assign px_data[13] = vid_io_r[4];  // G4
        assign px_data[14] = vid_io_r[13]; // B5
        assign px_data[15] = vid_io_r[7];  // G7
        assign px_data[16] = vid_io_r[18]; // R2
        assign px_data[17] = vid_io_r[3];  // G3
        assign px_data[18] = vid_io_r[12]; // B4
        assign px_data[19] = vid_io_r[6];  // G6
        assign px_data[20] = vid_io_r[17]; // R1
        assign px_data[21] = vid_io_r[2];  // G2
        assign px_data[22] = vid_io_r[11]; // B3
        assign px_data[23] = vid_io_r[23]; // R7
        assign px_data[24] = vid_io_r[16]; // R0
        assign px_data[25] = vid_io_r[1];  // G1
        assign px_data[26] = vid_io_r[10]; // B2
        assign px_data[27] = vid_io_r[22]; // R6
    end

    // Tx Clock Generator
    tx_clkgen_7to1 #(
        .CLKIN_PERIOD  ( CLKIN_PERIOD),
        .USE_PLL       (USE_PLL)
     )
     tx_clkgen (
        .clkin       (ref_clk),
        .reset       (reset),
        .px_clk      (px_clk),   // Transmit pixel clock for internal logic
        .tx_clkdiv2  (clkdiv2),  // Transmit clock at 1/2 data rate
        .tx_clkdiv4  (clkdiv4),  // Transmit clock at 1/4 data rate
        .cmt_locked  (locked)
    );
     
    assign cmt_locked = locked;

    // Synchronize locked status to px_clk domain
    always @ (posedge px_clk or negedge locked)
    begin
        if (!locked)
            px_locked <= 4'b000;
        else
            px_locked <= {1'b1,px_locked[3:1]};
    end
    assign px_reset = !px_locked[0];

    // TX - 4 Lines
    tx_channel_7to1 #(
      .LINES          (4), 
      .DATA_FORMAT    ("PER_CLOCK"),
      .CLK_PATTERN    (CLK_PATTERN),
      .TX_SWAP_MASK   (TX_SWAP_MASK)
    )
    tx_channel (
      .px_data        (px_data),
      .px_reset       (px_reset),
      .px_clk         (px_clk),
      .tx_clkdiv2     (clkdiv2),
      .tx_clkdiv4     (clkdiv4),
      .tx_clk_p       (clkout_p),
      .tx_clk_n       (clkout_n),
      .tx_out_p       (dataout_p),
      .tx_out_n       (dataout_n)
    );

endmodule
