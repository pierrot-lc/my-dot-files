return {
	{
		"nvim-neorg/neorg",
		ft = "neorg",
		cmd = "Neorg",
		build = ":Neorg sync-parsers",
		keys = {
			{ "<LocalLeader>c", ":Neorg toggle-concealer<CR>", desc = "Toggle conceiler" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"folke/zen-mode.nvim",
			"hrsh7th/nvim-cmp",
		},
		opts = {
			load = {
				-- Loads default behaviour.
				["core.defaults"] = {},
				-- Adds pretty icons to your documents.
				["core.concealer"] = {},
				-- Manages Neorg workspaces.
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/my-notes/",
						},
					},
				},
				-- Add completion support.
				["core.completion"] = {
					config = {
						engine = "nvim-cmp",
					},
				},
				-- Make any Norg file presentable.
				-- Use the `:Neorg presenter start` command.
				["core.presenter"] = {
					config = {
						zen_mode = "zen-mode",
					},
				},
			},
		},
	},
}
