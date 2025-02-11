	lab_PD1_sys u0 (
		.clk_clk         (<connected-to-clk_clk>),         //       clk.clk
		.reset_reset_n   (<connected-to-reset_reset_n>),   //     reset.reset_n
		.delay_out_valid (<connected-to-delay_out_valid>), // delay_out.valid
		.delay_out_data  (<connected-to-delay_out_data>),  //          .data
		.alu0_out_data   (<connected-to-alu0_out_data>),   //  alu0_out.data
		.alu0_out_ready  (<connected-to-alu0_out_ready>),  //          .ready
		.alu0_out_valid  (<connected-to-alu0_out_valid>),  //          .valid
		.alu1_out_data   (<connected-to-alu1_out_data>),   //  alu1_out.data
		.alu1_out_ready  (<connected-to-alu1_out_ready>),  //          .ready
		.alu1_out_valid  (<connected-to-alu1_out_valid>)   //          .valid
	);

