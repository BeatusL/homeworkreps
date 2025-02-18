// lab_PD2.v

// Generated using ACDS version 18.1 625

`timescale 1 ps / 1 ps
module lab_PD2 (
		input  wire       clk_clk,       //   clk.clk
		output wire [3:0] dout_export,   //  dout.export
		input  wire       reset_reset_n  // reset.reset_n
	);

	wire        sc_fifo_out_valid;      // sc_fifo:out_valid -> MyST_sink:asi_in0_valid
	wire  [3:0] sc_fifo_out_data;       // sc_fifo:out_data -> MyST_sink:asi_in0_data
	wire        sc_fifo_out_ready;      // MyST_sink:asi_in0_ready -> sc_fifo:out_ready
	wire        myst_source_out0_valid; // MyST_source:aso_out0_valid -> sc_fifo:in_valid
	wire  [3:0] myst_source_out0_data;  // MyST_source:aso_out0_data -> sc_fifo:in_data
	wire        myst_source_out0_ready; // sc_fifo:in_ready -> MyST_source:aso_out0_ready

	MyST_sink myst_sink (
		.csi_clk       (clk_clk),           //         clock.clk
		.rsi_reset     (~reset_reset_n),    //         reset.reset
		.asi_in0_data  (sc_fifo_out_data),  //           in0.data
		.asi_in0_valid (sc_fifo_out_valid), //              .valid
		.asi_in0_ready (sc_fifo_out_ready), //              .ready
		.coe_c0_Dout   (dout_export)        // conduit_end_0.export
	);

	MyST_source myst_source (
		.csi_clk        (clk_clk),                // clock.clk
		.rsi_reset      (~reset_reset_n),         // reset.reset
		.aso_out0_data  (myst_source_out0_data),  //  out0.data
		.aso_out0_ready (myst_source_out0_ready), //      .ready
		.aso_out0_valid (myst_source_out0_valid)  //      .valid
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (4),
		.FIFO_DEPTH          (16),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (0),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (3),
		.USE_MEMORY_BLOCKS   (1),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) sc_fifo (
		.clk               (clk_clk),                              //       clk.clk
		.reset             (~reset_reset_n),                       // clk_reset.reset
		.in_data           (myst_source_out0_data),                //        in.data
		.in_valid          (myst_source_out0_valid),               //          .valid
		.in_ready          (myst_source_out0_ready),               //          .ready
		.out_data          (sc_fifo_out_data),                     //       out.data
		.out_valid         (sc_fifo_out_valid),                    //          .valid
		.out_ready         (sc_fifo_out_ready),                    //          .ready
		.csr_address       (2'b00),                                // (terminated)
		.csr_read          (1'b0),                                 // (terminated)
		.csr_write         (1'b0),                                 // (terminated)
		.csr_readdata      (),                                     // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000), // (terminated)
		.almost_full_data  (),                                     // (terminated)
		.almost_empty_data (),                                     // (terminated)
		.in_startofpacket  (1'b0),                                 // (terminated)
		.in_endofpacket    (1'b0),                                 // (terminated)
		.out_startofpacket (),                                     // (terminated)
		.out_endofpacket   (),                                     // (terminated)
		.in_empty          (1'b0),                                 // (terminated)
		.out_empty         (),                                     // (terminated)
		.in_error          (1'b0),                                 // (terminated)
		.out_error         (),                                     // (terminated)
		.in_channel        (1'b0),                                 // (terminated)
		.out_channel       ()                                      // (terminated)
	);

endmodule
