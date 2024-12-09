	component ISSPE_lab is
		port (
			source     : out std_logic_vector(1 downto 0);                    -- source
			probe      : in  std_logic_vector(3 downto 0) := (others => 'X'); -- probe
			source_clk : in  std_logic                    := 'X'              -- clk
		);
	end component ISSPE_lab;

	u0 : component ISSPE_lab
		port map (
			source     => CONNECTED_TO_source,     --    sources.source
			probe      => CONNECTED_TO_probe,      --     probes.probe
			source_clk => CONNECTED_TO_source_clk  -- source_clk.clk
		);

