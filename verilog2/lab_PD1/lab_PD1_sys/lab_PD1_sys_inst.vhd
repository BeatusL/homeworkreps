	component lab_PD1_sys is
		port (
			clk_clk         : in  std_logic                     := 'X'; -- clk
			reset_reset_n   : in  std_logic                     := 'X'; -- reset_n
			delay_out_valid : out std_logic;                            -- valid
			delay_out_data  : out std_logic_vector(31 downto 0);        -- data
			alu0_out_data   : out std_logic_vector(31 downto 0);        -- data
			alu0_out_ready  : in  std_logic                     := 'X'; -- ready
			alu0_out_valid  : out std_logic;                            -- valid
			alu1_out_data   : out std_logic_vector(31 downto 0);        -- data
			alu1_out_ready  : in  std_logic                     := 'X'; -- ready
			alu1_out_valid  : out std_logic                             -- valid
		);
	end component lab_PD1_sys;

	u0 : component lab_PD1_sys
		port map (
			clk_clk         => CONNECTED_TO_clk_clk,         --       clk.clk
			reset_reset_n   => CONNECTED_TO_reset_reset_n,   --     reset.reset_n
			delay_out_valid => CONNECTED_TO_delay_out_valid, -- delay_out.valid
			delay_out_data  => CONNECTED_TO_delay_out_data,  --          .data
			alu0_out_data   => CONNECTED_TO_alu0_out_data,   --  alu0_out.data
			alu0_out_ready  => CONNECTED_TO_alu0_out_ready,  --          .ready
			alu0_out_valid  => CONNECTED_TO_alu0_out_valid,  --          .valid
			alu1_out_data   => CONNECTED_TO_alu1_out_data,   --  alu1_out.data
			alu1_out_ready  => CONNECTED_TO_alu1_out_ready,  --          .ready
			alu1_out_valid  => CONNECTED_TO_alu1_out_valid   --          .valid
		);

