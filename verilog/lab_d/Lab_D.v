module Lab_D (
 (* altera_attribute = "-name IO_STANDARD \"3.3-V LVCMOS\"", chip_pin = "23" *)
 input    CLK
 );
  
  wire       led_done;
  wire [4:0]   led_ROM;
  wire       key_reset;
  wire      key_restart;

Top_module U1_Top_module (
  .CLK        (CLK      ),
  .key_reset    (key_reset  ),
  .key_restart  (key_restart),
  .led_done    (led_done  ),
  .led_ROM      (led_ROM    )
);

MY_ISSPE U2_MY_ISSPE (
  .source      ({key_reset, key_restart}),
  .probe      ({led_done, led_ROM}),
  .source_clk    (CLK      )
);

endmodule