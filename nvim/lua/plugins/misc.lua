return {
	-- Fuck my life!
	{
		"Eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
		keys = {
			{ "<leader>Mf", "<cmd>CellularAutomaton make_it_rain<cr>", desc = "Make it rain!" },
		},
	},
	-- Show images directly in neovim.
	{
		"samodostal/image.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"m00qek/baleia.nvim", -- Color support.
		},
		opts = {
			render = {
				min_padding = 5,
				show_label = true,
				use_dither = true,
				foreground_color = true,
				background_color = true,
			},
			events = {
				update_on_nvim_resize = true,
			},
		},
		enabled = false,
	},
	-- Ask confirmation before editing .env files.
	{
		"roberte777/keep-it-secret.nvim",
		opts = {
			enabled = true,
		},
		enabled = false,
	},
}
