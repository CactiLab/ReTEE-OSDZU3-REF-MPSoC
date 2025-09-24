`timescale 1ps/1ps
module top_sim();

parameter       PIXEL_FORMAT = "RBG";     // Data Format - RGB or RBG
parameter       USE_ALPHA = 3; // Number of bytes per pixel - 3 (No) or 4 (Yes)

reg       refclk = 0;
reg       reset = 1;


reg  tx_clk = 0;     // Reference Clock input 
reg  tx_resetn = 1;       // Asynchronous interface reset
wire tx_cmt_locked;  // PLL/MMCM locked output
wire tx_px_clk;      // Pixel clock output

reg [7:0] red = 8'h0;
reg [7:0] green = 8'h0;
reg [7:0] blue = 8'h0;
reg vid_av = 1'b0;
reg vid_hs = 1'b0;
reg vid_vs = 1'b1;

wire [(8*USE_ALPHA)-1:0] vid_io_in;     // Pixel Data
wire  vid_active_video;    // Pixel Valid
wire  vid_hsync;           // Horizontal Sync
wire  vid_vsync;           // Vertical Sync

      
wire txrx_clk_p;     // Clock output LVDS P-side
wire txrx_clk_n;     // Clock output LVDS N-side
wire [3:0] txrx_data_p;    // Data output LVDS P-side
wire [3:0] txrx_data_n;    // Data output LVDS N-side

//reg  rx_resetn = 1;       // Asynchronous interface reset
//wire rx_cmt_locked;  // PLL/MMCM locked output

//wire rx_px_clk;
//wire rx_px_ready;

//wire [23:0] rx_pixel;     // First Pixel
//wire rx_fval;        // Frame Valid
//wire rx_lval;        // Line Valid
//wire rx_dval;        // Data Valid


//reg [15:0] cmd;
//reg  [7:0] addr;
//reg  [2:0] ctrl;

reg [10:0] cnt = 0;

reg [31:0] val;


initial
begin
 
   #10000
   tx_resetn = 1'b0;
      
end

always begin
   #6250 tx_clk = ~tx_clk;
end

always @ (negedge tx_clk)
begin
    
    if (tx_resetn) begin
        val <= 26'h1;
        red <= 8'h0;
        green <= 8'h0;
        blue <= 8'h0;
        vid_av <= 1'b0;
        vid_hs <= 1'b0;
        vid_vs <= 1'b1;
    end
    else begin
    
        val <= {val[30:0],val[31]};
        {red,green,blue,vid_av,vid_hs,vid_vs} <= val[26:0];
    
    end
end

//always @ (posedge tx_px_clk)
//begin
    
//    if (!rx_px_ready) begin
//        cnt <= 0;
//        addr <= 8'h40;
//        cmd <= 16'h4040;
//        ctrl <= 3'b0;
//    end
//    else begin
//        if(cnt%128 == 0) begin
////            if(cmd == 16'h8000) begin
////                cmd <= 16'h1;
////            end
////            else begin
////                cmd <= cmd<<1;
////            end
////            if(addr == 8'h80) begin
////                addr <= 8'h1;
////            end
////            else begin
////                addr <= addr<<1;
////            end
////            if(ctrl == 3'h4) begin
////                ctrl <= 3'h1;
////            end
////            else begin
////                ctrl <= ctrl<<1;
////            end
//        end
//        cnt <= cnt + 1;
//    end
//end

if(USE_ALPHA == 3) begin
    assign vid_io_in = {red,green,blue};
end
else begin
    assign vid_io_in = {8'h0,red,green,blue};
end

assign vid_active_video = vid_av;
assign vid_hsync = vid_hs;
assign vid_vsync = vid_vs;

lvds_display_tx #(
    .PIXEL_FORMAT(PIXEL_FORMAT), // Data Format - RGB or RBG
	.USE_ALPHA(USE_ALPHA),       // Number of bytes per Pixel
	.CLKIN_PERIOD(12.5),         // Clock period (ns) of input clock on clkin_p
    .USE_PLL("FALSE"),           // Enable PLL use rather than MMCM use
    .CLK_PATTERN(7'b1100011),    // Clock Pattern for Synchronization
    .TX_SWAP_MASK(16'h0000)      // Allows P/N inputs to be invered to ease PCB routing
   )
   tx_dut (
      .ref_clk(tx_clk),           // Reference Clock input - Tx Data frequency (~80 MHz)
      .reset(tx_resetn),          // Asynchronous interface reset
      .cmt_locked(tx_cmt_locked), // PLL/MMCM locked output
      .px_clk(tx_px_clk),         // Pixel clock output
      
      .vid_io_in(vid_io_in),        // Pixel Data
      .vid_active_video(vid_active_video), // Pixel Valid
      .vid_hsync(vid_hsync),        // Horizontal Sync
      .vid_vsync(vid_vsync),        // Vertical Sync

      .clkout_p(txrx_clk_p),     // Clock output LVDS P-side
      .clkout_n(txrx_clk_n),     // Clock output LVDS N-side
      .dataout_p(txrx_data_p),    // Data output LVDS P-side
      .dataout_n(txrx_data_n)    // Data output LVDS N-side
   );
   
   
   
endmodule
