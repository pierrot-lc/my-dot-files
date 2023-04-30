return {
	-- Fuck my life!
	{
		"Eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
		keys = {
			{ "<leader>mf", "<cmd>CellularAutomaton make_it_rain<cr>", desc = "Make it rain!" },
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
	-- Use nvim on browser.
	{
		"glacambre/firenvim",
		-- Lazy load firenvim
		-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
		cond = not not vim.g.started_by_firenvim,
		build = function()
			require("lazy").load({ plugins = "firenvim", wait = true })
			vim.fn["firenvim#install"](0)
		end,
	},
}
