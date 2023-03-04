return {
	-- Focus on a single buffer.
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		dependencies = {
			"folke/twilight.nvim",
		},
		opts = {
			window = {
				options = {
					number = false, -- Disable number column.
					signcolumn = "no",
					cursorline = false,
					cursorcolumn = false,
					foldcolumn = "0", -- Disable fold column.
				},
			},
			plugins = {
				tmux = {
					enabled = true,
				},
				gitsigns = {
					enabled = true,
				},
			},
			on_open = function(_)
				vim.diagnostic.disable()
			end,
			on_close = function()
				vim.diagnostic.enable()
			end,
		},
	},
	-- Dim inactive part of code.
	{
		"folke/twilight.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			context = 30,
			treesitter = true,
			expand = {
				"function",
				"method",
			},
		},
	},
}
